

require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  setup do
  @author_with_key = Author.create(name: "Martin", surname: "with key")
  @article_from_author_with_key = Article.create(title: "autore con chiave", body: "standard article body", status: "public", author_id: @author_with_key.id, language: "it")
  end

  #CREATE
  test "passing author key creates article" do
    post articles_url, params: {article: {title: "author has key", body: "standard article body for key testing", status: "public", language: "it"},
                        author_key: @author_with_key.key}
    assert_response :success
  end

  test "passing wrong author key does not create" do
    post articles_url, params: {article: {title: "author has key", body: "standard article body for key testing", status: "public", language: "it"},
                                author_key: "wrongkey666"}
    assert_response :bad_request
  end

  test "passing no author key does not create" do
    post articles_url, params: {article: {title: "author has key", body: "standard article body for key testing", status: "public",  language: "it"},
                                }
    assert_response :bad_request
  end

  test "article gets translated after creation" do
    post articles_url, params: {article: {title: "author has key", body: "autore con chiave", status: "public", language: "it"}, to_language: "en"
    }
    puts Article.first.inspect
    puts Article.last.inspect
  end

  #DESTROY
  test "passing author key destroys article" do
    delete article_url(@article_from_author_with_key), params: {author_key: @author_with_key.key}, as: :json
    assert_response :success
  end

  test "passing wrong author key does not destroy article" do
    delete article_url(@article_from_author_with_key), params: {author_key: "wrongkey666"}, as: :json
    assert_response :bad_request
  end


  test "passing no author key does not destroy article" do
    delete article_url(@article_from_author_with_key), as: :json
    assert_response :bad_request
  end


  #UPDATE
  test "passing author key updates article" do
    patch article_url(@article_from_author_with_key), params: {article: {title: "new title"}, author_key: @author_with_key.key}, as: :json
    @article_from_author_with_key.reload
    assert_response :success
    assert_equal @article_from_author_with_key.title, "new title"
  end

  test "passing wrong author key does not update article" do
    patch article_url(@article_from_author_with_key), params: {article: {title: "new title"}, author_key: "wrongkey666"}, as: :json
    assert_response :bad_request
  end


  test "passing no author key does not update article" do
    patch article_url(@article_from_author_with_key),params: {article: {title: "new title"}}, as: :json
    assert_response :bad_request
  end



end
