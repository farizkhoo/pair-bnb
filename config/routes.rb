Rails.application.routes.draw do
  root 'welcome#index'
  resources :passwords, controller: "passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]
  get "/listings/unverified" => "listings#unverified", as: "unverified_listings"
  resources :listings, controller: "listings", only: [:show, :index] #get "/listings" => "listings#index"

  resources :users, controller: "users", only: [:create] do
    resource :password, controller: "passwords", only: [:create, :edit, :update]
    resources :listings, controller: "listings", only: [:create, :edit, :update, :index]
  end

  # get "/listings"
  get "/users/edit" => "users#edit", as: "edit_user"
  post "/listings/:id/verify" => "listings#verify", as: "verify_listing"
  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/admin" => "admin#index", as: "admin"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
