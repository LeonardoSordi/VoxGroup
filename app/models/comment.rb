class Comment < ApplicationRecord

  include Visible

  belongs_to :article

  after_create :send_mail_to_article_author

  def send_mail_to_article_author
    ApplicationMailer.send_article(self.article).deliver_now
  end

end
