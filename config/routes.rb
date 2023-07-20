Rails.application.routes.draw do
  resources :recipes, only: [:inex]
  resources :users, only: [:show]
  post '/signup', to: 'users#create'
  get '/me', to: 'users#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
