Rails.application.routes.draw do

  get 'comment/create'

  get 'comment/update'

  get 'comment/destroy'

  resources :contacts

  devise_for :users

  devise_scope :user do
    get "/login" => "devise/sessions#new", as: :login
    get "/logout" => "sessions#destroy", as: :logout
  end

  root "users#dashboard"

  resources :contact
  resources :comments, only: [:create, :update, :destroy]
end
