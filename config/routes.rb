Rails.application.routes.draw do
  get 'welcome/home'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :reviews
  resources :movies
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "welcome#home"
end
