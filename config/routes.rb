Rails.application.routes.draw do

  devise_for :users, :skip => [:sessions]

  as :user do
    get ":uid/mark-all-read" => "users#read_all", as: :read_all_activities
    get "read/:uid" => "users#read_activity", as: :read_activity
    get "login" => "sessions#new", as: :new_user_session
    post 'login' => 'sessions#create', as: :user_session
    get "logout" => "sessions#destroy", as: :logout
  end

  root "users#dashboard"

  resources :tasks do
    member do
      get :view_comments
    end
  end
  resources :contacts do
    member do
      get :view_comments
    end
  end
  resources :comments, only: [:edit, :create, :update, :destroy]
end
