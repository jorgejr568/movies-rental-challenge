class RentalsController < ApplicationController
  before_action :authorize_request

  def initialize
    super
    @movie_service = MovieService.new
  end

  def index
    render json: MovieRentService.new(@current_user).list_rentals
  end

  def create
    movie = @movie_service.find_by_id(params[:movie_id])
    render json: MovieRentService.new(@current_user).rent_movie(movie)
  rescue MovieNotFound => e
    render json: { error: e.message }, status: :not_found
  end
end
