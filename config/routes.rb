Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    resources :users, only: [:index, :show, :update, :destroy]
    resources :dogs
  end

  root to: "pages#home"
  resources :conversations do
    resources :messages, only: [:index, :new, :create]
  end

  resources :events
  resources :communities, only: [:index, :show, :new, :create, :destroy] do
    resources :community_messages, only: :create
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
