Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  root to: 'users#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :labels
  resources :tasks do
    collection do
      post :confirm
    end  
  end
end
