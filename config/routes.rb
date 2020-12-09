Rails.application.routes.draw do
  root to: "tasks#index"
    resources :tasks
    resources :sessions, only: [:new, :create, :destroy]
    resources :users, only:[:new, :create, :show]
    namespace :admin do
  resources :users, only:[:index, :edit, :update, :new, :create, :show, :destroy]
  resources :users
  end
end
