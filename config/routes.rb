Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions
  resources :password_resets

  namespace :account do
    scope 'profile' do
     controller :profile do
       get :password
       put :update_password
     end
   end
  end

  namespace :admin do
    resources :subjects
  end
end
