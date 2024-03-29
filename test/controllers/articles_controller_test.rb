

require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest

  setup do
  @author_with_key = FactoryBot.create(:author)
  @article_from_author_with_key = FactoryBot.create(:article, author: @author_with_key )
  @translated_body = "Italian article text"

  end

  #CREATE
  test "passing author key creates article" do
    assert_enqueued_jobs 1 do
      post articles_url, params: {article: {title: "author has key", body: "standard article body for key testing", status: "public", language: "it"},
                          author_key: @author_with_key.key}
      assert_response :success
    end
  end

  test "passing wrong author key does not create" do
    assert_enqueued_jobs 0 do
    post articles_url, params: {article: {title: "author has key", body: "standard article body for key testing", status: "public", language: "it"},
                                author_key: "wrongkey666"}
    assert_response :bad_request
    end
  end


  test "passing no author key does not create" do
    assert_enqueued_jobs 0 do
      post articles_url, params: {article: {title: "author has key", body: "standard article body for key testing", status: "public",  language: "it"},
                                  }
      assert_response :bad_request
    end
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
