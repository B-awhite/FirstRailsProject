Rails.application.routes.draw do
  root 'sessions#home'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  # get '/auth/:provider', to: 'sessions#github'
  get '/auth/:provider/callback', to: 'sessions#github'
# /destination/:id/comment/
  resources :destinations do 
    resources :comments, only: [:new, :create, :index]
  end 
  resources :comments
  resources :users do 
    resources :destinations, only: [:new, :create, :index]
  end 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
