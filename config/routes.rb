Rails.application.routes.draw do
  # get "/products", to: "products#index"
  # get "/products/new", to: "products#new", as: :new_product
  # post "/products", to: "products#create"
  # patch "/products/:id", to: "products#update"
  # delete "/products/:id", to: "products#destroy"
  # get "/products/:id", to: "products#show", as: :product
  # get "/products/:id/edit", to: "products#edit", as: :edit_product
  namespace :authentication, path: "", as: "" do
    resources :users, only: [ :new, :create ], path: "/register", path_names: { new: "/" }
    resources :sessions, only: [ :new, :create, :destroy ], path: "/login", path_names: { new: "/" }
  end
  resources :categories, except: :show
  resources :products, path: "/"
end
