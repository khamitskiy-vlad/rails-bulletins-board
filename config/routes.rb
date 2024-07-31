# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'
    resources :categories
    resources :users
  end
  
  scope module: :web do
    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    get 'auth/failure', to: 'auth#failure', as: :failure_auth
    delete 'sign_out', to: 'auth#destroy', as: :destroy_session
  end
end
