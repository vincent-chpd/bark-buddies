Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    resources :users, only: [:index, :show, :update, :destroy]
    resources :dogs
  end

  root to: "pages#home"
  resources :conversations do
    resources :messages, only: [:create]
  end

  resources :dogs do
    post 'upload_photos', on: :member
  end

  resources :friendships, only: [:create, :destroy]
  patch 'conversations/:id/update_read_status', to: 'conversations#update_read_status', as: 'update_read_status'

  resources :events
  resources :searches, only: [:index]
  resources :communities, only: [:index, :show, :new, :create, :destroy] do
    resources :community_messages, only: :create
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
