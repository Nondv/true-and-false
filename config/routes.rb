Rails.application.routes.draw do
  resources :attempts
  # devise_for :users
  resources :statements
  root to: 'statements#index'
end
