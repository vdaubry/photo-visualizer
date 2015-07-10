Rails.application.routes.draw do
  root 'home#index'

  resources :sessions, only: [:create, :destroy]
  resources :websites, only: [:index]
end
