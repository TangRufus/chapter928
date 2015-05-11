Rails.application.routes.draw do
  resources :tickets, only: [:index, :new, :create]
  root to: 'tickets#index'
end
