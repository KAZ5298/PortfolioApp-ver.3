Rails.application.routes.draw do
  resource :sessions, only: [:new, :create, :destroy]
  resource :registrations, only: [:new, :create]
  root to: 'registrations#new'
end
