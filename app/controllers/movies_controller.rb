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
end