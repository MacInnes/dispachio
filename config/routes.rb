Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/register', to: 'register#new'
end
