Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root :to => 'orders#index'
  get '/signup' => 'users#new'


  get '/login' => 'sessions#new', as: :login_form
  post '/login' => 'sessions#create', as: :login
  get '/logout' => 'sessions#destroy', as: :logout


  resources :orders do
    member do
      post 'reorder'
    end
  end
  resources :drinks
  resources :drink_categories
  resources :users
  post '/users' => 'users#create'
end
