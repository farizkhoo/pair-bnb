Rails.application.routes.draw do
  get 'braintree/new'
  root 'welcome#index'
  resources :passwords, controller: "passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]
  get "/listings/unverified" => "listings#unverified", as: "unverified_listings"
  get "/listings/tobeverified" => "listings#tobeverified", as: "tobeverified_listings"


  get "/user/listings" => "listings#your_listings", as: "your_listings"
  get "/user/reservations" => "reservations#your_reservations", as: "your_reservations"


  resources :users, controller: "users", only: [:create] do
    resource :password, controller: "passwords", only: [:create, :edit, :update]
    resources :reservations, controller: "reservations", only: [:show]

    resources :listings, controller: "listings", only: [:new, :edit, :update, :index, :create] do
      resources :reservations, controller: "reservations", only: [:new, :create, :destroy, :show]
    end
  end


  resources :listings, controller: "listings", only: [:show, :index] do #get "/listings" => "listings#index"
    # resources :reservations, controller: "reservations", only: [:new, :create, :destroy]
  end
  # get "/listings"

  get "/user/edit" => "users#edit", as: "edit_user"
  patch "/user" => "users#update", as: "update_user"
  resources :users, controller: "users", only: [:edit]
  post "/listings/:id/verify" => "listings#verify", as: "verify_listing"
  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/admin" => "admin#index", as: "admin"
  get "/listings/:listing_id/reservations/new" => "reservations#new", as: "new_listing_reservation"
  get "/listings/:listing_id/reservations" => "reservations#listing_reservations", as: "listing_reservations"
  post "braintree/checkout"



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
