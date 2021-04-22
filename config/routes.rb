Rails.application.routes.draw do
  resource :registrations, only: [:new, :create]
  root to: 'registrations#new'
end
