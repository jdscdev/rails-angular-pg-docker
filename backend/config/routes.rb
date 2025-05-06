# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # Define the API namespace
  namespace :api do
    resources :users
    devise_for :users,
      path: '',
      path_names: {
        sign_in: 'login',
        sign_out: 'logout'
      },
      controllers: {
        sessions: 'api/sessions'
      }
    resources :products
    resources :orders do
      resources :order_items, only: %i[index create update destroy]
    end
  end
end
