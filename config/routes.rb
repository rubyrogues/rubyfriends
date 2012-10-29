Rubyfriends::Application.routes.draw do

  get '/about', to: 'tweets#about', as: :about
  resources :tweets, only: [:index, :show]
  root to: 'tweets#index'

end
