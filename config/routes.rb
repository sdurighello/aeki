Rails.application.routes.draw do

  devise_for :users
  resources :roles

  root 'products#index'

  # Users

  post 'profiles' => 'profiles#create'
  get 'profiles/new' => 'profiles#new', as: :new_profile
  get 'profiles/:id/edit' => 'profiles#edit', as: :edit_profile
  patch 'profiles/:id' => 'profiles#update'
  get 'profiles/:id' => 'profiles#show', as: :profile
  get 'profiles' => 'profiles#index'
  get 'user_list' => 'profiles#user_list', as: :user_list

  # Products

  get 'products/overview' => 'products#overview'
  get 'products' => 'products#index'
  get 'products/new' => 'products#new', as: :new_product
  get 'products/:id/edit' => 'products#edit', as: :edit_product
  post 'products' => 'products#create'
  patch 'products/:id' => 'products#update'
  get 'products/:id' => 'products#show', as: :product
  delete 'products/:id' => 'products#destroy'

  # Orders

  resources :orders do
    get 'pay_order' => 'orders#pay_order'
  end
  get 'history' => 'orders#history'

  # Inventory

  get 'inventory' => 'inventory#index'

  # Cart

  post 'add_to_cart' => 'products#add_to_cart', as: :add_to_cart
  post 'remove_from_cart' => 'products#remove_from_cart', as: :remove_from_cart

end
