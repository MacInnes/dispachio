Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/register', to: 'register#new'

  get '/login', to: 'login#new'

  get '/dispatcher/:id', to: 'dispatch#show'

  get '/driver/:id', to: 'driver#show'

  resources :users, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
        post '/login', to: 'login#create'
        get '/drivers', to: 'driver#index'
        get '/drivers/:id', to: 'driver#show'
        post '/drivers/:id/destination', to: 'driver#update'
        patch '/drivers/:id/location', to: 'driver#update_location'
        get '/dispatchers/:id', to: 'dispatcher#show'
        post '/dispatchers/:id/destination', to: 'dispatcher#update'
    end
  end
end
