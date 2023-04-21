class Api::MoviesController < Api::ApplicationController
  before_action :set_movie, only: %i[ show ]
  skip_before_action :doorkeeper_authorize!, only: %i[index]

  # GET /movies or /movies.json
  def index
    @movies = Movie.all
    render json: { result: @movies }, status: 200
  end

  # GET /movies/1 or /movies/1.json
  def show
    render json: { result: @movie }, status: 200
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  def share_movie
    byebug
    command = Movies::SharedMovie.call(params[:video_url], current_user)
    render json: { result: MovieSerializer.new(command.result) }, status: 200
  end

  def reaction_movie

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
