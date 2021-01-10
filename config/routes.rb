Rails.application.routes.draw do
  root 'home#index'
  namespace :api do
    resources :users, only: %i[index create show] do
      member do
        get :following, :followers
      end
    end
    resources :relationships, only: [:create, :destroy]
    resource :session, only: %i[create destroy] do
      post "guest_login", on: :collection
    end
    resources :microposts, only: %i[index create show update destroy] do
      resources :comments, only: [:create, :index]
      resources :likes, only: [:index, :create, :destroy]
      collection do
        get :likes
      end
    end
    resources :tags, only: %i[index]
    resources :genres, only: %i[index]
    namespace :me do
      resource :account, only: %i[update]
    end
  end
end
