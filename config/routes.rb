Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/register', to: 'register#new'

  get 'dispatcher', to: 'dispatch#index'

  resources :users, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
    end
  end
end
