class CommentsController < ApplicationController

  before_action :get_comment, only: [:destroy, :update]
  before_action :set_article_from_params, only: [:create]
  before_action :set_article_from_comment, only: [:show, :destroy]

  before_action :set_commenter, only: [:create, :update]
  before_action :set_article_creator, only: [:create, :destroy]

  before_action :forbid_creation_article_owner, only: [:create]
  before_action :forbid_destroy_if_not_owner, only: [:destroy]
  def create
    @article.comments.create(comment_params)
    render json: {comment: @article.comments.last, status: :success}
  end

  def show
      render json: {article:@article }, status: :ok
  end

  def destroy
    if @comment.destroy!
    render json: {message: "comment destroyed succesfully"}, status: :no_content
    else
      render json: {error: "could not destroy comment"}, status: :internal_server_error
    end

  end

  def update
  end


  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :status, :article_id)
  end
  def get_comment
    @comment = Comment.find(params[:id])
  end

  def set_article_from_comment
    @article = Article.find_by(id: @comment.article_id)
    if @article == nil
      render json: {error: "could not set article for this action"}, status: :bad_request
    end
  end

  def set_article_from_params
    @article = Article.find_by(id: comment_params[:article_id])
    if @article == nil
      render json: {error: "could not set article for this action"}, status: :bad_request
    end
  end

  def set_article_creator
    @article_creator = @article.author
  end

  def set_commenter
    if comment_params[:commenter].present?
    @commenter = Author.find_by(key:comment_params[:commenter])
    else
      render json: {error: "bad request error"}, status: :bad_request
    end
  end
  def forbid_creation_article_owner
    if comment_params[:commenter] == @article_creator.key
      render json: {error: "this author cannot delete this comment"}, status: :forbidden
    end
  end

  def forbid_destroy_if_not_owner
    unless params[:author_key]==@article.author.key || params[:author_key]==@comment.commenter
      render json: {error: "this author cannot delete this comment"}, status: :forbidden
    end
  end

end