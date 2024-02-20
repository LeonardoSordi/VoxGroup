class Comment < ApplicationRecord

  include Visible

  belongs_to :article

  after_create :send_mail_to_article_author


  def send_mail_to_article_author
    @article_author = self.article.author
    ApplicationMailer.with(author: @article_author).send_article(self.article).deliver_now
  end

end
