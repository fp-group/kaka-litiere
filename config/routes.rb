Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations'}
  root to: 'pages#home'
  get 'legal',  to: "pages#legal",  as: "legal"
  get 'shop',   to: "pages#shop",   as: "shop"

  namespace :admin do
    resources :products, only: [:index, :edit, :update]
  end
  resources :companies, only: [:new, :create]
  resources :orders, only: [:new, :create] do
    get 'success', to: "orders#success"
  end
  resources :shipping_addresses, only: [:create]
end
