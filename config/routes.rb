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

  get 'profiles/new' => 'profiles#new', as: :new_profile

  post 'add_to_cart' => 'products#add_to_cart', as: :add_to_cart

end
