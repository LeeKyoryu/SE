Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :account_activations, only: [:edit]
  root 'static_pages#home'
  #get  '/help',    to: 'static_pages#help'
  #get  '/about',   to: 'static_pages#about'
  #get  '/contact', to: 'static_pages#contact'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get '/game', to: 'sessions#game_start'

end
