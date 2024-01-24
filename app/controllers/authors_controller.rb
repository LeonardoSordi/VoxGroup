class AuthorsController < ApplicationController


  before_action :set_author, only: %i[ show edit update destroy ]
  before_action :check_key, only: [ :index, :show ]
  before_action :check_key_is_valid, only: [:destroy, :update, :show]
  def authenticate_author(author)

  end

  # GET /authors or /authors.json
  def index
    @authors = Author.all
    render json: {authors: @authors}, status: :ok
  end



  # POST /authors or /authors.json
  def create
    @author = Author.new(author_params)

      if @author.save

        render json: {author: @author}, status: :created
      else

        render json: {error: "author not saved"}, status: :unprocessable_entity

      end
  end

  # GET /authors/1 or /authors/1.json
  def show
    render json: {author: @author}, status: :ok
  end


  # PATCH/PUT /authors/1 or /authors/1.json
  def update

      if @author.update(author_params)

        render json: {author: @author}, status: :ok

      else
        render json: {error: "author could not be updated"}, status: :unprocessable_entity
      end
    end


  # DELETE /authors/1 or /authors/1.json
  def destroy
    if @author.destroy!
    render json: {message: "author destroyed"}, status: :no_content
    else
      render json: {errors: "could not destroy author"}, status: :internal_server_error
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

  def check_key
    unless author_params[:key].present?
      render json: {error: "bad request error"}, status: :bad_request
    end
  end

  def check_key_is_valid

    unless author_params[:key].present? && author_params[:key] == @author.key
      render json: {error: "bad request error"}, status: :bad_request
    end
  end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:name, :surname, :age, :key)
    end
end
