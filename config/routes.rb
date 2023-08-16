Rails.application.routes.draw do
  root 'movies#index'

  resources :movies, only: %i[index] do
    get :recommendations, on: :collection
  end

  get '/movies/favorites', to: 'movies#favorites'
  post '/movies/favorites', to: 'movies#mark_as_favorite'

  resources :rentals, only: %i[index create]

  post '/auth', to: 'users#sign_in'
  get '/auth', to: 'users#me'
end
