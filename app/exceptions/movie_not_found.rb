# frozen_string_literal: true

class MovieNotFound < Exception
  def initialize(msg = 'Movie not found')
    super
  end
end
