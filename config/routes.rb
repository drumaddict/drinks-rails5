Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root :to => 'dashboard#index'
   get '/signup' => 'users#new'

   post '/users' => 'users#create'

  get '/login' => 'sessions#new', as: :login_form
  post '/login' => 'sessions#create', as: :login
  get '/logout' => 'sessions#destroy', as: :logout

  resources :orders
  resources :drinks
  resources :drink_categories
end
