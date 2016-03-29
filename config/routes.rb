# == Route Map
#
#              Prefix Verb   URI Pattern                                       Controller#Action
#                root GET    /                                                 home#index
#                sell GET    /sell(.:format)                                   events#index
#      user_dashboard GET    /dashboard(.:format)                              users#show
#      event_listings POST   /events/:event_id/listings(.:format)              listings#create
#   new_event_listing GET    /events/:event_id/listings/new(.:format)          listings#new
#              events GET    /events(.:format)                                 events#index
#               event GET    /events/:id(.:format)                             events#show
#                cart GET    /cart(.:format)                                   carts#show
#        cart_tickets POST   /cart_tickets(.:format)                           cart_tickets#create
#         cart_ticket PATCH  /cart_tickets/:id(.:format)                       cart_tickets#update
#                     PUT    /cart_tickets/:id(.:format)                       cart_tickets#update
#                     DELETE /cart_tickets/:id(.:format)                       cart_tickets#destroy
# mailing_list_emails POST   /mailing_list_emails(.:format)                    mailing_list_emails#create
#         user_orders GET    /users/:user_id/orders(.:format)                  orders#index
#                     POST   /users/:user_id/orders(.:format)                  orders#create
#      new_user_order GET    /users/:user_id/orders/new(.:format)              orders#new
#          user_order GET    /users/:user_id/orders/:id(.:format)              orders#show
#         user_thanks GET    /users/:user_id/orders/:order_id/thanks(.:format) orders#thanks
#                     POST   /users/:user_id/orders(.:format)                  orders#create
#       user_listings GET    /users/:user_id/listings(.:format)                listings#index
#        user_listing GET    /users/:user_id/listings/:id(.:format)            listings#show
#                     PATCH  /users/:user_id/listings/:id(.:format)            listings#update
#                     PUT    /users/:user_id/listings/:id(.:format)            listings#update
#                     DELETE /users/:user_id/listings/:id(.:format)            listings#destroy
#               users POST   /users(.:format)                                  users#create
#            new_user GET    /users/new(.:format)                              users#new
#        orderhistory GET    /orderhistory(.:format)                           orders#index
#           ordershow GET    /ordershow(.:format)                              orders#show
#              thanks GET    /thanks(.:format)                                 orders#thanks
#            checkout GET    /checkout(.:format)                               orders#new
#     admin_dashboard GET    /admin/dashboard(.:format)                        admin/events#index
#      admin_comments POST   /admin/comments(.:format)                         admin/comments#create
#         admin_users GET    /admin/users(.:format)                            admin/users#index
#          admin_user PATCH  /admin/users/:id(.:format)                        admin/users#update
#                     PUT    /admin/users/:id(.:format)                        admin/users#update
#        admin_events GET    /admin/events(.:format)                           admin/events#index
#     new_admin_event GET    /admin/events/new(.:format)                       admin/events#new
#        admin_venues GET    /admin/venues(.:format)                           admin/venues#index
#     new_admin_venue GET    /admin/venues/new(.:format)                       admin/venues#new
#    admin_categories GET    /admin/categories(.:format)                       admin/categories#index
#                     POST   /admin/categories(.:format)                       admin/categories#create
#  new_admin_category GET    /admin/categories/new(.:format)                   admin/categories#new
#      admin_category PATCH  /admin/categories/:id(.:format)                   admin/categories#update
#                     PUT    /admin/categories/:id(.:format)                   admin/categories#update
#          admin_tags GET    /admin/tags(.:format)                             admin/tags#index
#       new_admin_tag GET    /admin/tags/new(.:format)                         admin/tags#new
#           admin_tag GET    /admin/tags/:id(.:format)                         admin/tags#show
#      checkout_login GET    /orders/login(.:format)                           orders#checkout_login
#       checkout_user POST   /orders/login(.:format)                           orders#checkout_user
#               login GET    /login(.:format)                                  sessions#new
#                     POST   /login(.:format)                                  sessions#create
#              logout DELETE /logout(.:format)                                 sessions#destroy
#                     GET    /:name(.:format)                                  categories#show
#

Rails.application.routes.draw do
  root to: 'home#index'

  get '/sell', to: 'events#index', as: 'sell'
  get "/dashboard", to: "users#show", as: "user_dashboard"

  resources :events, only: [:index, :show] do
    resources :listings, only: [:new, :create]
  end

  resource :cart, only: [:show]
  resources :cart_tickets, only: [:create, :destroy, :update]
  resources :mailing_list_emails, only: [:create]

  resources :users, only: [:new, :create] do
    resources :orders, only: [:new, :index, :create, :show]
    get "/orders/:order_id/thanks", to: "orders#thanks", as: "thanks"
    resources :orders, only: [:create] #took out index and show
    #get "/orders/:order_id/thanks", to: "orders#thanks", as: "thanks"
    resources :listings, only: [:index, :show, :update, :destroy]
  end

  get "/orderhistory", to: "orders#index"

  get "/ordershow", to: "orders#show"

  get "/thanks", to: "orders#thanks", as: "thanks"

  get "/checkout", to: "orders#new"

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
