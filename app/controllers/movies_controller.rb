class MoviesController < ApplicationController
  before_action :authorize_request, except: [:index]

  def index
    @movies = Movie.all
    render json: @movies
  end

  def recommendations
    favorite_movies = @current_user.favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: @recommendations
  end

  def user_rented_movies
    @rented = @current_user.rented
    render json: @rented
  end

  def rent
    movie = Movie.find(params[:id])
    movie.available_copies -= 1
    movie.save
    @current_user.rented << movie
    render json: movie
  end
end