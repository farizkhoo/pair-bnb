Rails.application.routes.draw do
  root 'welcome#index'
  resources :passwords, controller: "passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]
  get "/listings/unverified" => "listings#unverified", as: "unverified_listings"
  get "/listings/tobeverified" => "listings#tobeverified", as: "tobeverified_listings"

  resources :users, controller: "users", only: [:create] do
    resource :password, controller: "passwords", only: [:create, :edit, :update]
    resources :reservations, controller: "reservations", only: [:index, :show]

    resources :listings, controller: "listings", only: [:new, :edit, :update, :index, :create] do
      resources :reservations, controller: "reservations", only: [:new, :create, :destroy]
    end
  end


  resources :listings, controller: "listings", only: [:show, :index] do #get "/listings" => "listings#index"
    # resources :reservations, controller: "reservations", only: [:new, :create, :destroy]
  end
  # get "/listings"
  
  get "/users/edit" => "users#edit", as: "edit_user"
  resources :users, controller: "users", only: [:edit]
  post "/listings/:id/verify" => "listings#verify", as: "verify_listing"
  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/admin" => "admin#index", as: "admin"
  get "/listings/:listing_id/reservations/new" => "reservations#new", as: "new_listing_reservation"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
