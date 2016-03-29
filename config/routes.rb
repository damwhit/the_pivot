Rails.application.routes.draw do
  root to: 'home#index'

  get '/sell', to: 'events#index', as: 'sell'
  get "/dashboard", to: "users#show", as: "user_dashboard"

  resources :listings, only: [:index, :show]
  resources :events, only: [:index, :show] do
    resources :listings, only: [:new, :create]
  end

  resource :cart, only: [:show]
  resources :cart_tickets, only: [:create, :destroy, :update]
  resources :mailing_list_emails, only: [:create]

  resources :users, only: [:new, :create] do
    resources :orders, only: [:index, :create, :show]
    get "/orders/:order_id/thanks", to: "orders#thanks", as: "thanks"
    resources :orders, only: [:create] #took out index and show
  end

  get "/ordershow", to: "orders#show"

  get "/checkout", to: "orders#new"
  post "/checkout", to: "orders#create"

  namespace :admin do
    get "/dashboard", to: "events#index"
    #resources :products, only: [:new, :create, :index, :update]
    #resources :orders, only: [:index, :show, :update]
    resources :comments, only: [:create]
    resources :users, only: [:index, :update]
    resources :events, only: [:index, :new]
    resources :venues, only: [:index, :new]
    resources :categories, only: [:index, :new, :create, :update]
    resources :tags, only: [:index, :new, :show]
  end


  get "orders/login", to: "orders#checkout_login", as: "checkout_login"
  post "orders/login", to: "orders#checkout_user", as: "checkout_user"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/:name", to: "categories#show"
end
