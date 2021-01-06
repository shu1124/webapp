Rails.application.routes.draw do
  root 'home#index'
  namespace :api do
    resources :users, only: %i[create]
    resource :session, only: %i[create destroy]
  end
end
