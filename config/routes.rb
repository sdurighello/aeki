Rails.application.routes.draw do
  resources :roles
  devise_for :users

  get 'products' => 'products#index'
  get 'products/:id' => 'products#show'

  root 'products#index'
end
