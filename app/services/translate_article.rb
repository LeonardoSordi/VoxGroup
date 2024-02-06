class TranslateArticle

  attr_accessor :translator
  attr_reader :errors

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
      if translated_text!=false
        @article.body=translated_text
        @article.language=@to_language


        unless @article.save
          @errors.push("#{@article.errors.full_messages}")
        end

      else
        @errors += @translator.errors
        end
    end
    self
  end

  def translate_article

    response = self.translate_service

    if response != false
      response
    else
      @errors = @translator.errors
    end
  end

  def translate_service
    @translator.call_translation(@article.body, @from_language, @to_language)
  end

  def saved?
    unless @article.id.present?
      @errors.push("Error: article not saved")
    end
    @article.id.present?
  end

  def errors?
    @errors.size.zero? == false
  end
end