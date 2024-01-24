class TranslateArticle

  def self.call(from_text)
    english_text = GoogleApi::Translate.call(from_text, 'it', 'en')
  end


end