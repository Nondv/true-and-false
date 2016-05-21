Rails.application.routes.draw do
  # devise_for :users
  resources :statements
  root to: 'statements#index'
end
