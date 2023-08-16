# frozen_string_literal: true

class MovieService
  def list_all
    Movie.all
  end

  def find_by_id(id)
    Movie.find id
  rescue ActiveRecord::RecordNotFound
    raise MovieNotFound
  end

  # @param [User] user
  def mark_as_favorite(user, movie)
    user.favorites << movie unless user.favorites.include? movie
  end
end
