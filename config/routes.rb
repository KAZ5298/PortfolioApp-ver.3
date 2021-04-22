Rails.application.routes.draw do
  resource :registrations, only: [:new, :create]
end
