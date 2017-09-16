Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:index]

  get 'login' => 'sessions#new', as: 'login'
  delete 'logout' => 'sessions#destroy', as: 'logout'
  get 'signup' => 'users#new', as: 'signup'

  root to: 'home#index'
end
