require "test_helper"

class TranslateArticleTest < ActiveSupport::TestCase



  setup do
    @author=Author.create(name:"giovanni", surname: "giorgio")
    @article = Article.new(title: "titolo articolo", body: "testo articolo in italiano", status: :public, author: @author, language: "it")
    @nil_client_translator_error = "Could not translate article: connection with client is not established"
    @expected_body_translation = "article text in Italian"

  end

  test 'translate' do
    obj = TranslateArticle.new(@article, "it", "en")

    obj.class_eval do
      define_method(:translate_service, -> { "translation string" })
    end

    obj.call

    assert obj.saved?
    assert_equal @expected_body_translation , @article.body
  end

  test "nil client produces error on call_translation inside translator" do

    translator = GoogleApi::Translate.new()
    translator.client = nil
    translator.call_translation(@article.language, "en" , @article.body)
    assert_includes(translator.errors, @nil_client_translator_error)

  end

end
