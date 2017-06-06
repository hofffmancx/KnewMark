Rails.application.routes.draw do

  require 'sidekiq/web'
  require 'admin_constraint'
  mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new

  root 'knowledges#index'

  resources :users
  resources :sessions
  resources :password_resets


  resources :categories, only: [:index, :show]

  resources :reviews do
    resources :comments
    post :like, on: :member
    post :unlike, on: :member
  end

  resources :comments do
    post :like, on: :member
    post :unlike, on: :member
  end

  resources :discussions do
    post :like, on: :member
    post :unlike, on: :member
  end

  resources :knowledges do
    resources :reviews
    resources :discussions
    resources :questions do
      resources :anwsers
    end

    member do
      post :rate
      post :like
      post :follow
      post :star
      post :unlike
      post :unfollow
      post :unstar
      post :want
      post :unwant
      post :have
      post :unhave
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
       get :edit
       put :update_profile
     end
   end
   resources :knowledges do
     member do
       post :remove
     end
   end
  end

  namespace :admin do
    resources :subjects
    resources :users do
      collection do
        post :bulk_mail
      end
    end
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
