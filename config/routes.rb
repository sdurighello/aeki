Rails.application.routes.draw do
  devise_for :users

  get 'products' => 'products#index'

end
