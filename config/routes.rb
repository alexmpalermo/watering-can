Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/home' => 'users#home', :as => :home
  get '/signup' => 'users#signup', :as => :signup
  post '/signup' => 'users#create'
  get '/login' => 'sessions#login', :as => :login
  post '/login' => 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/home')



  resources :users

  resources :dispensers do
    resources :plants
  end


end
