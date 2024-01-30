class TranslateArticle

  attr_reader :errors

  def self.call_translator(article, from_language, to_language)
    new(article, from_language, to_language).call
  end

  def initialize(article, from_language, to_language)
    @article = article
    @from_language = from_language
    @to_language = to_language
    @errors = []
  end

  def call
    if @from_language == @to_language || @article.language == @to_language
      @errors.push( "Bad language selection" )
    else
      translated_text = self.translate_service
        unless translated_text==false
        @article.body=translated_text
        @article.language=@to_language
        @article.save
        end
      end
    return self
  end

  def translate_service
    service = GoogleApi::Translate.call_translation(@article.body, @from_language, @to_language)
    if service==false
      self.errors.add(service.errors)
    end
  end


  def saved?
    @article.id.present?
  end

  def errors?
    @errors.size.zero? == false
  end

end