Rails.application.routes.draw do
  resources :tickets, only: [:index, :new, :create, :show]
  root to: 'tickets#index'
end
