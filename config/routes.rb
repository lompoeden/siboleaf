Rails.application.routes.draw do
  resources :labels
  root 'users#new'
  resources :tasks
  resources :sessions
  resources :users
  namespace :admin do
    resources :users
  end
end
