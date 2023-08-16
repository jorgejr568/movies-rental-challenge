# frozen_string_literal: true

class MovieService
  def initialize
    @movie = Movie.new
  end

  def list_all
    @movie.all
  end
end
