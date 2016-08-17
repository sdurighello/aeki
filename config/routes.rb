Rails.application.routes.draw do
  resources :orders
  resources :roles
  root 'products#index'
  # resources :products
  get 'products' => 'products#index'
  get 'products/new' => 'products#new', as: :new_product
  post 'products' => 'products#create'
  get 'products/:id' => 'products#show', as: :product

  #devise_for :users

end
