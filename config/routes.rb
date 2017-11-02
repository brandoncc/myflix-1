Myflix::Application.routes.draw do
  root to: 'pages#front'

  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
  get '/home', to: 'videos#index'

  resources :users, only: [:create, :show]
  resources :categorys, only: [:show]

  get '/my_queue', to: 'queue_items#index'
  post '/my_queue/update', to: 'queue_items#update'
  resources :queue_items, only: [:create, :destroy]

  get '/people', to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]

  resources :videos, only: [:show] do
    collection do
      get '/search', to: 'videos#search'
    end

    resources :reviews, only: [:create]
  end

  get 'ui(/:action)', controller: 'ui'
end
