Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'admin_constraint'
  mount Sidekiq::Web => '/sidekiq', :constraints => AdminConstraint.new
  mount Notifications::Engine => "/notifications"
  root 'knowledges#index'
  resources :notifications
  resources :users
  resources :sessions
  resources :password_resets

  resources :categories, only: [:index, :show]
  post 'photos' => 'photos#upload'

  resources :reviews do
    resources :comments
    post :like, on: :member
    post :unlike, on: :member
  end

  resources :cellphone_tokens, only: [:create]

  resources :comments do
    post :like, on: :member
    post :unlike, on: :member
  end

  resources :discussions do
    post :like, on: :member
    post :unlike, on: :member
  end

  resources :questions do
    resources :anwsers
  end
  get "/post", to: "posts#index"

  resources :knowledges do
    resources :activities
    resources :reviews
    resources :discussions
    resources :questions
    resources :events


    member do
      post :rate
      post :like
      post :follow
      post :mark
      post :unlike
      post :unfollow
      post :unmark
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
    resource :user
    scope 'profile' do
     controller :profile do
       get :password
       put :update_password
       get :edit
       put :update_profile
     end
   end
   resources :knowledges
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
