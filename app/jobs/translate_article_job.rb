class TranslateArticleJob < ApplicationJob
  queue_as :default

  def perform(article)
    errors = []
    translate = TranslateArticle.call_translator(article.dup, "it", "en")
    if translate.saved?
      return true
    else
      errors.add(:to_language, translate.errors.join(", "))
      return errors
    end
  end


end
