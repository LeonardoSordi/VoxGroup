class ArticlesController < ApplicationController

  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :set_author, only: [:create]
  before_action :check_author_key_is_valid, only: [:create]



  #C - Create

  def create
    #new article
    @new_article = Article.new(article_params)
    @new_article.author_id = @author.id


    #check authentication
    if @author.key !="" and @author.key !=nil
      #check if saved
      if @new_article.save
        render json: @new_article.errors, status: :created
      else
        render json: @new_article.errors, status: :unprocessable_entity
      end
    else
      render json: { errors: @new_article.errors.full_messages }, status: :bad_request
    end
  end


  #R - Read
  def index
    @articles = Article.all
    render json: {articles: @articles}, status: 200
  end

  #U - Update
  def update
      respond_to do |format|
        if @article.update(article_params)
          format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
          format.json { render :show, status: :ok, location: @article}
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @article.errors, status: :unprocessable_entity }
        end
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

  def check_author_key_is_valid
    if @author.key != params[:author_key]
      render json: {}, status: :bad_request
    end
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
