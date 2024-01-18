require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @article_creator = Author.create(name: "Martin", surname: "with key")
    @commenter = Author.create(name: "andrea", surname: "with key")
    @article = Article.create(title: "author has key", body: "standard article body", status: "public", author_id: @article_creator.id)

  end

  test "article creator cannot comment its article" do
    post article_comments_url(@article), params: {comment: {commenter: @article_creator, body: "comment body.", status: "public", article_id: @article.id }}, as: :json
    assert_response :forbidden
  end

end
