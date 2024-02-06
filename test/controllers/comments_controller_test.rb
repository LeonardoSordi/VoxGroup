require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @article_creator = FactoryBot.create(:author)
    @comment_creator = FactoryBot.create(:author)
    @random_author =  FactoryBot.create(:author)
    @article = FactoryBot.create(:article, author: @article_creator)
    @comment = FactoryBot.create(:comment, article: @article, commenter: @comment_creator.key)
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
