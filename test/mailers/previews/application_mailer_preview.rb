class ApplicationMailerPreview < ActionMailer::Preview
  def send_article
    ApplicationMailer.with(author: Author.first).send_article(Article.first)
  end
end