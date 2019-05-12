Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'

  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/login')

  resources :reviews
  resources :movies
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "welcome#home"
end
