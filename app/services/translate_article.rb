class TranslateArticle
  def self.call_translator(article, from_language, to_language)

    if from_language == to_language || article.language == to_language
      return "Bad language selection"
    else

      translated_text = GoogleApi::Translate.call_translation(article.body, from_language, to_language)
      article.body=translated_text
      article.language=to_language

    end
  end
end