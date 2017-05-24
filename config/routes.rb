Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  resources :sessions
  resources :password_resets
  resources :knowledges do
    collection do
      get :search
    end
    member do
      post :add
      post :buy
    end
  end

  namespace :account do
    scope 'profile' do
     controller :profile do
       get :password
       put :update_password
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
