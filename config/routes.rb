Rails.application.routes.draw do
  root 'home#index'

  resources :sessions, only: [:create, :destroy]
  resources :websites, only: [:index]
  resources :posts, only: [:show]
  resources :user_images, only: [:index, :create]

  namespace :user do
    resources :websites, only: [:index, :update, :destroy]
  end
end
