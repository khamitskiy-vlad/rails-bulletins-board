# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'
    resources :bulletins, only: :show
    resources :categories, only: :show
    shallow do
      scope module: :users do
        resources :users, only: [:new, :create, :show, :edit, :update, :destroy] do
          resources :bulletins, only: :create
          get 'profile', on: :member
        end
        resources :bulletins, only: [:new, :edit, :update, :destroy]
      end
    end
  end

  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback'
    get 'auth/failure', to: 'auth#failure', as: :failure_auth
    resources :sessions, only: [:new, :create] do
      delete :destroy, on: :collection, as: :destroy
    end
  end

  scope module: :web do
    namespace :admin do
      root 'dashboard#index'
      resources :bulletins do
        member do
          patch :moderation
          patch :publish
          patch :to_correction
          patch :archive
        end
      end
      scope module: :categories do
        resources :categories do
          resources :bulletins, only: :index
        end
      end
      scope module: :users do
        resources :users do
          resources :bulletins, only: :index
        end
      end  
    end
  end
end
