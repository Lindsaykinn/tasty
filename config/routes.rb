Rails.application.routes.draw do
  resources :comments
  resources :categories
  resources :recipes
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
