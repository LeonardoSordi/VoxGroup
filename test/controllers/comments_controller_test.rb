require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @article_creator = Author.create(name: "Martin", surname: "with key")
    @comment_creator = Author.create(name: "Andrea", surname: "with key")
    @random_author = Author.create(name: "7", surname: "with key")
    @article = Article.create(title: "author has key", body: "standard article body", status: "public", author_id: @article_creator.id)
    @comment = Comment.create(commenter: @comment_creator.key, body: "testo commento", status: "public", article_id: @article.id)
  end

  test "article creator cannot comment its article" do
    post article_comments_url(@article), params: {comment: {commenter: @article_creator.key, body: "comment body.", status: "public", article_id: @article.id }}, as: :json
    assert_response :forbidden
  end

  test "authors can comment articles" do
    post article_comments_url(@article), params: {comment: {commenter: @comment_creator.key, body: "comment body.", status: "public", article_id: @article.id }}, as: :json
    assert_response :success
  end

  test "comment creator can destroy comment" do
    delete article_comment_url(@article, @comment), params: {author_key: @comment_creator.key}
    assert_response :no_content
  end


  test "article creator can destroy comment" do
    delete article_comment_url(@article, @comment), params: {author_key: @article_creator.key}
    assert_response :no_content
  end

  test "random authors cannot destroy comment" do
    delete article_comment_url(@article, @comment), params: {author_key: @random_author.key}
    assert_response :forbidden
  end


end
