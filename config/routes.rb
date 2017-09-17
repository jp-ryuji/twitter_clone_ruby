Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create] do
    post :follow
    delete :unfollow
  end
  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:index]
  resources :posts, only: [:create]

  get 'login' => 'sessions#new', as: 'login'
  delete 'logout' => 'sessions#destroy', as: 'logout'
  get 'signup' => 'users#new', as: 'signup'

  root to: 'home#index'
end
