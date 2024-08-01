# frozen_string_literal: true

Rails.application.routes.draw do
  get 'panel/index'
  scope module: :web do
    root 'bulletins#index'
    resources :bulletins
    resources :users
  end

  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/failure', to: 'auth#failure', as: :failure_auth
    delete 'sign_out', to: 'auth#destroy', as: :destroy_session
  end

  scope module: :web do
    namespace :admin do
      root 'panel#index'
      resources :bulletins
      resources :categories
      resources :users
    end
  end
end
