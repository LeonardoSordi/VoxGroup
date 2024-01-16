class ArticlesController < ApplicationController

  before_action :set_article, only: %i[ show edit update destroy ]

  #C - Create
  def new
    @article = Article.new
  end

  def create
    #new article
    @new_article = Article.new(article_params)
    @author_key_new_article = @new_article.author.key

    #check authentication
    if @author_key_new_article!="" and @author_key_new_article!=nil
      #check if saved
      if @new_article.save
        render json: @new_article.errors, status: :created
      else
        render json: @new_article.errors, status: :unprocessable_entity
      end

    else
      render json: { errors: @new_article.errors.full_messages }, status: :forbidden
    end
  end


  #R - Read
  def index

    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id]) 
  end

  #U . Update
  def edit
  end

  def update
    if @author_key!="" and @author_key!=nil

      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
          format.json { render :show, status: :ok, location: @article}
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
      end

    else
      render json: { errors: @article.errors.full_messages }, status: :forbidden
    end

  end
  #D - Destroy
  def destroy

    if @author_key!="" and @author_key!=nil
    @article.destroy!
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
    else
      render json: { errors: @article.errors.full_messages }, status: :forbidden
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
    @author_key = @article.author.key
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :author_id)
    end
end
