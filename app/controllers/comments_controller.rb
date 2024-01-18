class CommentsController < ApplicationController

  before_action :set_article_from_params, only: [:create]
  before_action :set_article_creator, only: [:create]
  before_action :forbid_article_owner, only: [:create]
    def create
      @article.comments.create(comment_params)
      render json: {comment: @article.comments.last, status: :success}
    end

    def destroy
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
    @article_creator = comment_params[:commenter]
  end
  def set_commenter
    if Author.find_by(key: params[:author_key]).present?
      @commenter = Author.find_by(key: params[:author_key])
    else
      render json: {}, status: :bad_request
    end
  end
  def forbid_article_owner
    if @commenter == @article_creator
      render json: {}, status: :forbidden
    end
  end

end