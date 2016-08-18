Rails.application.routes.draw do

  root 'products#index'

  resources :orders
  resources :roles

  # resources :products
  get 'products' => 'products#index'
  get 'products/new' => 'products#new', as: :new_product
  get 'products/:id/edit' => 'products#edit', as: :edit_product
  post 'products' => 'products#create'
  patch 'products/:id' => 'products#update'
  get 'products/:id' => 'products#show', as: :product
  delete 'products/:id' => 'products#destroy'

  devise_for :users

  get 'profiles/new' => 'profiles#new', as: :new_profile

  post 'add_to_cart' => 'products#add_to_cart', as: :add_to_cart

end
