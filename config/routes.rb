Rails.application.routes.draw do
  
  resources :instructions
  root to: 'static#home'

  resources :ingredients

  resources :comments

  resources :categories do
    resources :recipes, only: [:index, :show]
  end

  resources :recipes do
    resources :comments, only: [:index, :new, :create]
    resources :recipe_ingredients, only: [:index, :new, :create]
    resources :categories, only: [:index, :new, :create]
  end  

  resources :recipe_ingredients do
    collection do
      delete 'destroy_multiple'
    end
  end
    
  resources :users
  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy', as: 'destroy_user_session'

  match '/auth/:google_oauth2/callback' => 'sessions#omniauth', via: [:get, :post]

end
