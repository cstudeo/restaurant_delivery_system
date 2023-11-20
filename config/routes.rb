Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :users
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :orders, except: [:edit]
  root 'restaurants#index'
  resources :carriers, only: [:index, :edit, :update] do
    post :update_availibilty, on: :collection
    post :verification_details, on: :collection
    get :show_order, on: :member
  end

  resources :carts, only: [:update]
  resources :order_items
  resources :payments, only: [:create]
  resources :restaurants, only: [:index] do
    resources :food_items, only: [:index]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
