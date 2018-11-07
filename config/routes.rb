Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/register', to: 'register#new'

  get '/dispatcher', to: 'dispatch#index'

  get '/driver', to: 'driver#index'

  resources :users, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
        get '/drivers/:id/destination', to: 'driver#show'
        post '/drivers/:id/destination', to: 'driver#update'
        get '/dispatcher', to: 'dispatcher#index'
    end
  end
end
