Rails.application.routes.draw do
  root to: 'statements#index'
  resources :statements
end
