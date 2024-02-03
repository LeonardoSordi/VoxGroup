require "test_helper"

class TranslateArticleTest < ActiveSupport::TestCase



  setup do
    @author=Author.create(name:"giovanni", surname: "giorgio")
    @invalid_article = Article.new(body: "testo articolo in italiano", author: @author, language: "it")
    @article = Article.new(title: "titolo articolo", body: "testo articolo in italiano", status: :public, author: @author, language: "it")
    @nil_client_translation_error = "Could not translate article: client is nil"
    @expected_body_translation = "article text in Italian"
  end

  test 'translate' do
    obj = TranslateArticle.new(@article, "it", "en")
    obj.class_eval do
      define_method(:translate_service, -> { "translation string" })
    end
    obj.call
    assert obj.saved?
  end

  test "nil client error propagates to translator service" do
    translator = GoogleApi::Translate.new
    translator.client = nil
    translator.call_translation(@article.language, "en" , @article.body)
    assert_includes(translator.errors, @nil_client_translation_error)
  end

  test "article saving failures makes errors? return true" do
    translator_service_obj = TranslateArticle.new(@invalid_article, "it", "en")
    translator_service_obj.call

    assert_equal translator_service_obj.saved?, false
    assert translator_service_obj.errors?
  end

  test "nil client error makes errors? function return true" do

    translator = GoogleApi::Translate.new
    translator.client = nil
    translator_service_obj = TranslateArticle.new(@invalid_article, "it", "en")
    translator_service_obj.translator = translator
    translator_service_obj.call
    assert translator_service_obj.errors?

  end

end
