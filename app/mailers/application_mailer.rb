class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  def send_article(article)

    @author = params[:author]

    @subject = article.body

    mail(to: @author.mailaddress, subject: @subject)

  end
end
