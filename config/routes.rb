Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help', to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/link', to: 'static_pages#link'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
