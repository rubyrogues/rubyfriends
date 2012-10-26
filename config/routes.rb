Rubyfriends::Application.routes.draw do

  get '/:id', to: 'rubyfriends_app#show'
  root to: 'rubyfriends_app#index'

end
