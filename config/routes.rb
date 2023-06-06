Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get "/ingredients", to: "ingredients#index"
  resources :ingredients, only: [:index]

  # get "/recipes/:id", to: "recipes#show"
  resources :recipes, only: [:show]

  # post "recipe_ingredients", to: "recipe_ingredients#create"
  resources :recipe_ingredients, only: [:create]
end
