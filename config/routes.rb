Rails.application.routes.draw do
  resource :sessions, only: [:new, :create, :destroy]
  resource :settings, only: [:edit, :update]
  resource :registrations, only: [:new, :create]
  resources :users, only: [:index, :show] do
    get :favorites, on: :member
  end
  resources :tweets do
    resource :favorites, only: [:create, :destroy]
  end
  root to: 'registrations#new'
end
