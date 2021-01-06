Rails.application.routes.draw do
  root 'home#index'
  namespace :api do
    resources :users, only: %i[create]
    resource :session, only: %i[create destroy]
    resources :microposts, only: %i[index create show update destroy]
  end
end
