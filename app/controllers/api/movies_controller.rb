class Api::MoviesController < Api::ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[ index ]

  # GET /movies or /movies.json
  def index
    @movies = Movie.all
    render :json => @movies, each_serializer: MovieSerializer, status: 200
  end

  def show
    render json: { result: @movie }, status: 200
  end

  def create
    command = Movies::SharedMovie.call(params[:video_url], current_user)
    render json: { result: MovieSerializer.new(command.result, scope: current_user) }, status: 200
  end

  def reaction_movie
    command = Movies::ReactionMovie.call(movie_params, current_user)
    render json: { result: MovieSerializer.new(command.result, scope: current_user) }, status: 200
  rescue => ex
    render json: { errors: ex.message }, status: 500
  end

  private
  def movie_params
    params.permit(:id, :type_reaction)
  end
end
