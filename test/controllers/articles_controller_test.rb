require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  setup do

  @author_with_key = Author.create(name: "Martin", surname: "with key")
  @article_from_author_with_key = Article.create(title: "author has key", body: "standard article body", status: "public")
  end

  test "passing author key creates article" do
    post articles_url, params: {article: {title: "author has key", body: "standard article body for key testing", status: "public"},
                        author_key: @author_with_key.key}
    assert_response :success
  end

  test "passing wrong author key returns bad request" do
    post articles_url, params: {article: {title: "author has key", body: "standard article body for key testing", status: "public"},
                                author_key: "wrongkey666"}
    assert_response :bad_request
  end

  test "passing no author key returns bad request" do
    post articles_url, params: {article: {title: "author has key", body: "standard article body for key testing", status: "public"},
                                }
    assert_response :bad_request
  end

  /
  test "update article checks author key" do

    new_title = "New Title"

    #Call PATCH on articles
    patch article_url(@article_from_author_with_key), params: { article: { title: new_title  } }, as: :json
    assert_response :success
    patch article_url(@article_from_author_without_key), params: { article: { title: new_title  } }, as: :json
    assert_response :forbidden

    #refresh instances
    @article_from_author_without_key.reload
    @article_from_author_with_key.reload

    #assertions
    assert_equal(@article_from_author_with_key.title, new_title)
    assert_not_equal(@article_from_author_without_key.title, new_title)

  end


  test "destroy article checks author key" do

    #Call DESTROY on articles
    delete article_url(@article_from_author_with_key), as: :json
    assert_response :success
    delete article_url(@article_from_author_without_key), as: :json
    assert_response :forbidden

  end

  test "create article checks author key" do

    #initialize new articles
    new_article_from_author_with_key = Article.new(title: "author has key", body: "standard new article body", status: "public", author_id: @author_with_key.id)
    new_article_from_author_without_key = Article.new(title: "author does not have key", body: "standard new article body", status: "public", author_id: @author_without_key.id)

    #Call CREATE on articles
    post articles_url, params: {article: new_article_from_author_with_key},  as: :json
    assert_response :success
    post articles_url, params: {article: new_article_from_author_without_key}, as: :json
    assert_response :forbidden

  end/

end
