# frozen_string_literal: true

# Purpose: Movie rent service
class MovieRentService
  # @param [User] user
  def initialize(user)
    @user = user
  end

  def list_rentals
    # return @user.rentals with movie relationships
    @user.rentals.includes(:movie).map do |rental|
      {
        **rental.attributes,
        movie: rental.movie
      }
    end
  end

  def rent_movie(movie)
    ActiveRecord::Base.transaction do
      movie.available_copies -= 1
      movie.save!
      @user.rented << movie
    end

    @user.rentals.last
  end
end
