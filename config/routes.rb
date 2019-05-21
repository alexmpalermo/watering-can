Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/home' => 'users#home', :as => :home
  get '/signup' => 'users#signup', :as => :signup
  post '/signup' => 'users#create', :as => :signup
  get '/login' => 'sessions#login', :as => :login
  post '/login' => 'sessions#create', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout

  resources :users

  resources :dispensers do
    resources :plants
  end


end
