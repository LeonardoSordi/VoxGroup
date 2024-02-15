class TranslateArticleJob < ApplicationJob
  queue_as :default

  def perform(article)
    TranslateArticle.call_translator(article.dup, "it", "en")
  end


end
