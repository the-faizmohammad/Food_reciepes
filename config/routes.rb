Rails.application.routes.draw do
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  devise_for :users
  root 'public_recipes#index'
  resources :public_recipes, only: %i[index show]
  resources :recipes, only: %i[index show new create destroy update edit] do    
    resources :recipe_foods
  end
  resources :foods, only: %i[index show new create destroy]
  resources :general_shopping_lists, only: %i[index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end