Rails.application.routes.draw do
  root 'users#new'
    resources :tasks
    resources :sessions, only: [:new, :create, :destroy]
    resources :users, only:[:new, :create, :show]
    namespace :admin do
  resources :users, only:[:index, :edit, :update, :new, :create, :show, :destroy]
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  resources :users
  end
end
