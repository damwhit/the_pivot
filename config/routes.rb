Rails.application.routes.draw do
  root to: 'home#index'

  get '/sell', to: 'events#index', as: 'sell'

  resources :products, only: [:index, :show]
  resource :cart, only: [:show]
  resources :cart_products, only: [:create, :destroy, :update]
  resources :mailing_list_emails, only: [:create]

  resources :users, only: [:new, :create, :show] do
    get "/dashboard", to: "users#show"
    resources :orders, only: [:new, :index, :create, :show]
    get "/orders/:order_id/thanks", to: "orders#thanks", as: "thanks"
    resources :listings, only: [:new, :index]
  end

  namespace :admin do
    get "/dashboard", to: "events#index"
    resources :products, only: [:new, :create, :index, :update]
    resources :orders, only: [:index, :show, :update]
    resources :comments, only: [:create]
    resources :users, only: [:index]
    resources :events, only: [:index]
  end


  get "orders/login", to: "orders#checkout_login", as: "checkout_login"
  post "orders/login", to: "orders#checkout_user", as: "checkout_user"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/category", to: "categories#show"
  get "/event", to: "events#show"
end
