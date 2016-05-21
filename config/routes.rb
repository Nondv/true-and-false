Rails.application.routes.draw do
  devise_for :users
  root to: 'statements#index'
  resources :statements
end
