require "test_helper"

class ArticleTest < ActiveSupport::TestCase



  setup do
    @author=FactoryBot.create(:author)
    @translated_body = "translation string"
  end

  test "article duplicat gets created after article creation" do
    assert_enqueued_jobs 1 do
      assert_difference 'Article.count', 2 do
        Article.create(title: "titolo articolo", body: "autore con chiave", status: "public", author_id: @author.id, language: "it")
      end
    end
  end


  test "article doesn't get translated because already in english" do
    assert_enqueued_jobs 1 do
      assert_difference 'Article.count', 1 do
        Article.create(title: "titolo articolo", body: "autore con chiave", status: "public", author_id: @author.id, language: "en")
      end
    end
  end


  test "article duplicate is the translated version of the original" do

    assert_enqueued_jobs 1 do
      @article=FactoryBot.create(:article, title: "titolo articolo", body: "autore con chiave", status: "public", author_id: @author.id, language: "it")
      translated_article = Article.last
      assert_equal translated_article.body, @translated_body
    end
  end


  test "original article body does not get modified upon translation" do
    original_body = "autore con chiave"
    assert_enqueued_jobs 1 do
      @article=FactoryBot.create(:article, title: "titolo articolo", body: original_body, status: "public", author_id: @author.id, language: "it")
      assert_equal @article.body, original_body
    end
  end



end
