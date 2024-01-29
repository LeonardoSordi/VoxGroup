require "test_helper"

class TranslateArticleTest < ActiveSupport::TestCase



  setup do
    @author=Author.create(name:"giovanni", surname: "giorgio")
    @article = Article.new(title: "rjeiwfjweoi", body: "fhsjdfhdjsfhsd", status: :public, author: @author, language: "it")
  end

  test 'translate' do
    obj = TranslateArticle.new(@article, "it", "en")

    obj.class_eval do
      define_method(:translate_service, -> { "translation string" })
    end

    obj.call

    assert obj.saved?
    assert_equal "translation string", @article.body
  end

end
