Rails.application.routes.draw do
  resource :sessions, only: [:new, :create, :destroy]
  resource :settings, only: [:edit, :update]
  resource :registrations, only: [:new, :create]
  resources :users, only: [:index, :show]
  root to: 'registrations#new'
end
