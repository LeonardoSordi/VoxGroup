class TranslateArticle

  def self.call(article_object)
    english_text = GoogleApi::Translate.call(article_object.body, 'it', 'en')
  end


end