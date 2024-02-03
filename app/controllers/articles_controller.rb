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
        render json: {article: @new_article}, status: :created
      else
        render json: @new_article.errors, status: :unprocessable_entity
      end

  end

  # GET /authors/1 or /authors/1.json
  def show
    render json: {article: @article}, status: :ok
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
    if @article.destroy!
    render json: {message: "article destroyed"}, status: :no_content
    else
      render json: {error: "could not destroy article"}, status: :internal_server_error
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
    @author_key = @article.author.key
    if @article == nil
      render json: {error: "could not set article"}, status: :internal_server_error
    end
  end


  def set_author
    if Author.find_by(key: params[:author_key]).present?
      @author = Author.find_by(key: params[:author_key])
    else
      render json: {error: "bad request error"}, status: :bad_request
    end
  end



  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :author_id, :language)
    end
  end

