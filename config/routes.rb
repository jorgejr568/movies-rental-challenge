Rails.application.routes.draw do
  root 'movies#index'

  resources :movies, only: %i[index] do
    get :recommendations, on: :collection
    get :user_rented_movies, on: :collection
    get :rent, on: :member
  end

  post '/auth', to: 'users#sign_in'
  get '/auth', to: 'users#me'
end
