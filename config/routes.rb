Rails.application.routes.draw do
  resources :categories, except: :show
  # get "/products", to: "products#index"
  # get "/products/new", to: "products#new", as: :new_product
  # post "/products", to: "products#create"
  # patch "/products/:id", to: "products#update"
  # delete "/products/:id", to: "products#destroy"
  # get "/products/:id", to: "products#show", as: :product
  # get "/products/:id/edit", to: "products#edit", as: :edit_product
  resources :products, path: "/"

  namespace :authentication, path: "", as: "" do
    resources :users, only: [ :new, :create ]
    resources :sessions, only: [ :new, :create ]
  end
end
