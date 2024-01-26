require "test_helper"

class ArticleTest < ActiveSupport::TestCase



  setup do
    @author=Author.create(name:"giovanni", surname: "giorgio")
  end

  test "article duplicat gets created after article creation" do
    article_count = Article.count
    @article=Article.create(title: "titolo articolo", body: "autore con chiave", status: "public", author_id: @author.id, language: "it")
    assert_equal Article.count, article_count+2
  end

  test "article duplicate is the translated version of the original" do

    @article=Article.create(title: "titolo articolo", body: "autore con chiave", status: "public", author_id: @author.id, language: "it")
    translated_body="author with key"
    translated_article = Article.last

    assert_equal translated_article.body, translated_body
  end

  test "original article body does not get modified upon translation" do
    original_body = "autore con chiave"
    @article=Article.create(title: "titolo articolo", body: original_body, status: "public", author_id: @author.id, language: "it")
    assert_equal @article.body, original_body
  end

end
