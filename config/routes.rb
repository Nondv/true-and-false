Rails.application.routes.draw do
  get '/users/me', to: 'users#show_current_user'

  resources :users
  post '/answer/:id', to: 'game#make_a_guess'
  root 'game#random_gamecard'

  resources :attempts
  # devise_for :users
  resources :statements
end
