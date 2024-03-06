Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    resources :dogs
  end

  root to: "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check
end
