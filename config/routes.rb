Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :users

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'restaurants#index'
  # resources :food_items
  resources :restaurants, only: [:index] do
    resources :food_items, only: [:index]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
