Rubyfriends::Application.routes.draw do

  get '/about', to: 'rubyfriends_app#about', as: :about
  get 'tweets/:id', to: 'rubyfriends_app#show', as: :tweet
  root to: 'rubyfriends_app#index'

end
