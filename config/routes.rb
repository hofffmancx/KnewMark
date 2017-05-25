Rails.application.routes.draw do

  root 'categories#index'

  resources :users
  resources :sessions
  resources :password_resets

  resources :categories, only: [:index, :show]

  resources :knowledges do
    resources :reviews
    member do
      post :rate
      post :like
      post :follow
      post :star
      post :unlike
      post :unfollow
      post :unstar
    end
    collection do
      get :search
    end
  end

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
    resources :categories
    resources :knowledges do
      member do
        post :reject
        post :publish
        post :hide
      end
      collection do
        get :search
      end
    end
  end
end
