Rails.application.routes.draw do
  get 'orders/history' => 'orders#history'
  resources :orders
  resources :roles
  root 'products#index'
  # resources :products
  get 'products' => 'products#index'
  get 'products/new' => 'products#new', as: :new_product
  get 'products/:id/edit' => 'products#edit', as: :edit_product
  post 'products' => 'products#create'
  patch 'products/:id' => 'products#update'
  get 'products/:id' => 'products#show', as: :product
  delete 'products/:id' => 'products#destroy'

  get 'orders' => 'orders#index'

  devise_for :users

  post 'profiles' => 'profiles#create'
  get 'profiles/new' => 'profiles#new', as: :new_profile
  get 'profiles/:id/edit' => 'profiles#edit', as: :edit_profile
  patch 'profiles/:id' => 'profiles#update'
  get 'profiles/:id' => 'profiles#show', as: :profile

  post 'add_to_cart' => 'products#add_to_cart', as: :add_to_cart

end
