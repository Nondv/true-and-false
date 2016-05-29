Rails.application.routes.draw do
  resources :users
  post '/answer/:id', to: 'game#make_a_guess'
  root 'game#random_gamecard'

  resources :attempts
  # devise_for :users
  resources :statements
end
