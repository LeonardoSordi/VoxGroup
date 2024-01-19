class CommentsController < ApplicationController


  before_action :set_article_from_params, only: [:create]
  before_action :set_commenter, only: [:create, :update]
  before_action :set_article_creator, only: [:create]
  before_action :forbid_creation_article_owner, only: [:create]
  def create
    @article.comments.create(comment_params)
    render json: {comment: @article.comments.last, status: :success}
  end

  def destroy
  end

  def update
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body, :status, :article_id)
  end
  def get_comment
    @comment = Comment.find(params[:comment_id])
  end

  def set_article_from_comment
    @article = Article.find_by(id: @comment.article_id)
  end

  def set_article_from_params
    @article = Article.find_by(id: comment_params[:article_id])
  end

  def set_article_creator
    @article_creator = @article.author
  end

  def set_commenter
    if comment_params[:commenter].present?
    @commenter = Author.find_by(key:comment_params[:commenter])
    else
      render json: {}, status: :bad_request
    end
  end
  def forbid_creation_article_owner
    if comment_params[:commenter] == @article_creator.key
      render json: {}, status: :forbidden
    end
  end

end