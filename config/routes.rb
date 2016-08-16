Rails.application.routes.draw do
  resources :roles
  root 'products#index'

  get 'products' => 'products#index'
  get 'products/new' => 'products#new'
  get 'products/:id' => 'products#show', as: :product

  #devise_for :users

end
