require 'factory_bot_rails'
class ApplicationMailerPreview < ActionMailer::Preview
  include FactoryBot::Syntax::Methods
  def send_article
    Article.suppress do
      @article = FactoryBot.create(:article)
    end
    ApplicationMailer.send_article(@article)
  end
end