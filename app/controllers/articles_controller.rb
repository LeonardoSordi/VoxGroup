class ArticlesController < ApplicationController

  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :set_author, only: [:create, :update, :destroy]

  #C - Create

  def create
    #new article
    @new_article = Article.new(article_params)
    @new_article.author_id = @author.id
      #check if saved
      if @new_article.save
        render json: @new_article.errors, status: :created
      else
        render json: @new_article.errors, status: :unprocessable_entity
      end

  end

  #R - Read
  def index
    @articles = Article.all
    render json: {articles: @articles}, status: 200
  end

  #U - Update
  def update
        if @article.update(article_params)
          render :show, status: :ok, location: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
  end
  #D - Destroy
  def destroy
    @article.destroy!
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
    @author_key = @article.author.key
  end


  def set_author
    if Author.find_by(key: params[:author_key]).present?
      @author = Author.find_by(key: params[:author_key])
    else
      render json: {}, status: :bad_request
    end
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :author_id)
    end
end
