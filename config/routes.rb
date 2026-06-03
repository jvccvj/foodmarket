Rails.application.routes.draw do
  namespace :api do
    resources :prices, only: [:index, :show]
  end
  
  get 'charts', to: 'charts#index'
  root 'charts#index'
end