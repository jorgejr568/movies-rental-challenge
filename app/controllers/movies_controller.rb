class MoviesController < ApplicationController
  before_action :authorize_request, except: [:index]

  def initialize
    super
    @movie_service = MovieService.new
  end

  def index
    render json: @movie_service.list_all
  end

  def recommendations
    favorite_movies = @current_user.favorites
    render json: RecommendationEngine.new(favorite_movies).recommendations
  end

  def mark_as_favorite
    movie = @movie_service.find_by_id(params[:movie_id])
    @movie_service.mark_as_favorite(@current_user, movie)
    head :created, content_type: 'application/json'
  rescue MovieNotFound => e
    render json: { error: e.message }, status: :not_found
  end

  def favorites
    render json: @current_user.favorites
  end
end
