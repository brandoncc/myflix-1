Myflix::Application.routes.draw do
  root to: 'pages#front'

  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
  get '/home', to: 'videos#index'

  get '/my_queue', to: 'queue_items#index'

  resources :users, only: [:create]
  resources :categorys, only: [:show]
  resources :queue_items, only: [:create, :destroy]

  resources :videos, only: [:show] do
    collection do
      get '/search', to: 'videos#search'
    end

    resources :reviews, only: [:create]
  end

  get 'ui(/:action)', controller: 'ui'
end
