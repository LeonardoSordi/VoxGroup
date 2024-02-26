class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  def send_article(article)

    @subject = article.body
    @author = article.author
    mail(to: @author.mailaddress, subject: @subject)

  end
end
