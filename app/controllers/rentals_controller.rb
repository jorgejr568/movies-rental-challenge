class RentalsController < ApplicationController
  before_action :authorize_request

  def index
    render json: MovieRentService.new(@current_user).list_rentals
  end

  def create
    movie = Movie.find(params[:movie_id])
    MovieRentService.new(@current_user).rent_movie(movie)
  end
end
