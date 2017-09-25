Myflix::Application.routes.draw do
  root to: 'pages#front'

  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
  get '/home', to: 'videos#index'

  resources :users, only: [:create]

  resources :videos, only: [:show] do
    collection do
      get '/search', to: 'videos#search'
    end
  end

  get 'ui(/:action)', controller: 'ui'
end
