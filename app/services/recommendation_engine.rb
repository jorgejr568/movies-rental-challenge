# Purpose: This class is responsible for generating movie recommendations based on the user's favorite movies.
class RecommendationEngine
  def initialize(favorite_movies)
    @favorite_movies = favorite_movies
  end

  def recommendations
    movie_titles = get_movie_names
    genres = Movie.where(title: movie_titles).pluck(:genre)
    common_genres = genres.group_by { |e| e }.sort_by { |k, v| -v.length }.map(&:first).take(3)
    Movie.where(genre: common_genres).order(rating: :desc).limit(10)
  end

  private

  def get_movie_names
    names = []
    @favorite_movies.map do |movie|
      names << movie.title
    end

    names
  end
end