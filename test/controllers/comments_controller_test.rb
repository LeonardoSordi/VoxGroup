require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @article_creator = Author.create(name: "Martin", surname: "with key")
    @commenter = Author.create(name: "Andrea", surname: "with key")
    @article = Article.create(title: "author has key", body: "standard article body", status: "public", author_id: @article_creator.id)
  end

  test "article creator cannot comment its article" do
    post article_comments_url(@article), params: {comment: {commenter: @article_creator.key, body: "comment body.", status: "public", article_id: @article.id }}, as: :json
    assert_response :forbidden
  end

  test "authors can comment articles" do
    post article_comments_url(@article), params: {comment: {commenter: @commenter.key, body: "comment body.", status: "public", article_id: @article.id }}, as: :json
    assert_response :success
  end

end
