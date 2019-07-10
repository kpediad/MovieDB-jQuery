Rails.application.routes.draw do

  get '/loggedin_user', to: 'sessions#loggedin_user'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root to: "welcome#home"

  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/login')


  resources :users, except: [:index, :show]
  resources :movies, except: :destroy do
    resources :reviews
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
