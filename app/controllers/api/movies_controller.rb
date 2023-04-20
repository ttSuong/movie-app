class Api::MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    @movies = Movie.all
    render json: { movies: @movies }, status: 200
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  def share_movie

  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create

  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update

  end

  # DELETE /movies/1 or /movies/1.json
  def destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :url, :total_liked, :total_disliked, :shared_by, :description)
    end
end
