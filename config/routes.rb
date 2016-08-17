Rails.application.routes.draw do
  resources :roles
  root 'products#index'
  # resources :products
  get 'products' => 'products#index'
  get 'products/new' => 'products#new', as: :new_product
  get 'products/:id/edit' => 'products#edit', as: :edit_product
  post 'products' => 'products#create'
  patch 'products/:id' => 'products#update'
  get 'products/:id' => 'products#show', as: :product

  devise_for :users

end
