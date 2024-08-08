# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'
    resources :bulletins
    resources :categories, only: :show
    resources :users, only: [:show, :edit, :update]
  end

  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/failure', to: 'auth#failure', as: :failure_auth
    delete 'sign_out', to: 'auth#destroy', as: :destroy_session
  end

  scope module: :web do
    namespace :admin do
      root 'dashboard#index'
      resources :bulletins
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
