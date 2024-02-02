class TranslateArticle

  attr_accessor :errors

  def self.call_translator(article, from_language, to_language)
    new(article, from_language, to_language).call
  end

  def initialize(article, from_language, to_language)
    @article = article
    @from_language = from_language
    @to_language = to_language
    @errors = []
    @translator_service = GoogleApi::Translate.new
  end

  def call
    if @from_language == @to_language || @article.language == @to_language
      @errors.push( "Bad language selection" )
    else
      translated_text = self.translate_article
      puts translated_text.inspect

        unless translated_text==false
        @article.body=translated_text
        @article.language=@to_language
        @article.save
        end
    end
    #Propagates errors to article model
    @errors += @translator_service.errors
    self
  end

  def translate_article
    if @translator_service.client==nil
      false
    else
      @translator_service.call_translation(@article.body, @from_language, @to_language)
    end

  end


  def saved?
    @article.id.present?
  end

  def errors?
    @errors.size.zero? == false
  end
end