class TranslateArticle

  attr_accessor :errors, :translator

  def self.call_translator(article, from_language, to_language)
    new(article, from_language, to_language).call
  end

  def initialize(article, from_language, to_language)
    @article = article
    @from_language = from_language
    @to_language = to_language
    @errors = []
    @translator = GoogleApi::Translate.new
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

    self
  end

  def translate_article
    if @translator.client==nil

      #Propagates errors to this class
      @errors += @translator.errors

      false
    else
      @translator.call_translation(@article.body, @from_language, @to_language)
    end

  end


  def saved?
    unless @article.id.present?
      @errors.push("Error: article not saved ")
    end

    @article.id.present?
  end

  def errors?
    @errors.size.zero?
  end
end