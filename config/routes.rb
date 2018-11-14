Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/register', to: 'register#new'

  get '/dispatcher/:id', to: 'dispatch#show'

  get '/driver/:id', to: 'driver#show'

  resources :users, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      get '/drivers', to: 'driver#index'
      get '/drivers/:id/destination', to: 'driver#show'
      post '/drivers/:id/destination', to: 'driver#update'
      get '/dispatchers/:id', to: 'dispatcher#show'
      post '/dispatchers/:id/destination', to: 'dispatcher#update'
    end

    namespace :v2 do
      resources :drivers, only: [:create, :show] do
        post 'update_location', to: 'drivers/location#update'
      end
      resources :dispatchers, only: [:create]
    end
  end
end
