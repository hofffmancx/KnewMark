Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions
  resources :password_resets
end
