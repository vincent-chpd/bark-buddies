Rails.application.routes.draw do
  get 'communities/index'
  get 'communities/show'
  get 'communities/new'
  get 'communities/create'
  get 'communities/destroy'
  devise_for :users

  devise_scope :user do
    resources :users, only: [:index, :show, :update, :destroy]
    resources :dogs
  end

  resources :conversations do
    resources :messages, only: [:index, :new, :create]
  end

  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
end
