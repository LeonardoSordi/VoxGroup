class AuthorsController < ApplicationController
  before_action :set_author, only: %i[ show edit update destroy ]
  before_action :check_key, only: [ :index, :show ]
  before_action :check_key_is_valid, only: [:destroy, :update]
  def authenticate_author(author)

  end

  # GET /authors or /authors.json
  def index
    @authors = Author.all
    render json: {authors: @authors}, status: 200
  end

  # GET /authors/1 or /authors/1.json
  def show
    @author = Author.find(params[:id])
    render json: {author: @author}, status: 200
  end


  # GET /authors/1/edit
  def edit
  end

  # POST /authors or /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to author_url(@author), notice: "Author was successfully created." }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /authors/1 or /authors/1.json
  def update

    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to author_url(@author), notice: "Author was successfully updated." }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # DELETE /authors/1 or /authors/1.json
  def destroy
    @author.destroy!

    respond_to do |format|
      format.html { redirect_to authors_url, notice: "Author was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

  def check_key
    unless params[:key].present?
      render json: {}, status: :forbidden
    end
  end
  
  def check_key_is_valid
    unless params[:key].present? && params[:key] == @author.key
      render json: {}, status: :forbidden
    end
  end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:name, :surname, :age, :key)
    end
end
