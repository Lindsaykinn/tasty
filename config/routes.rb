Rails.application.routes.draw do
  
  root to: 'static#home'
  
  resources :instructions


  resources :categories do
    resources :recipes, only: [:index, :show, :new]
  end

  resources :recipes do
    resources :categories, only: [:index, :new, :create]
  end  


  resources :users, only: [:show, :new, :index] do
    resources :recipes, only: [:index, :show]
  end
    
  resources :users
  get '/signup', to: 'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy', as: 'destroy_user_session'

  match '/auth/:google_oauth2/callback' => 'sessions#omniauth', via: [:get, :post]

end
