Myflix::Application.routes.draw do
  root to: 'pages#front'

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
  get '/home', to: 'videos#index'

  get '/register', to: 'users#new'
  resources :users, only: [:create, :show]
  resources :categories, only: [:show]

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

  get "forgot_password", to: "forgot_passwords#new"
  get "confirm_reset", to: "forgot_passwords#confirm_reset"
  resources :forgot_passwords, only: [:create]

  get "expired_token", to: "password_resets#expired_token"
  resources :password_resets, only: [:show, :create]

  get "invite_user", to: "invite_users#new"
  resources :invite_users, only: [:create]

  get 'ui(/:action)', controller: 'ui'
end
