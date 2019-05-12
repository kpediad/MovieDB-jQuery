Rails.application.routes.draw do
  get 'welcome/home'
  get 'sessions/new', as: :login
  get 'sessions/create'
  get 'sessions/destroy'
  resources :reviews
  resources :movies
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "welcome#home"

  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')
end
