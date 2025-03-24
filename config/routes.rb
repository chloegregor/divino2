Rails.application.routes.draw do
  # get 'box_echanges/new'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root "vinyards#index"
  # Defines the root path route ("/")
  # root "posts#index"

  #

  resources :vinyards
  resources :dividendes

  resources :users, only: [:show] do
    resources :exchanges, only: [:index, :create]
    member do
      post "accept", to: "exchanges#accepted_exchanges"
      post "reject", to: "exchanges#rejected_exchanges"
    end
    resources :box_exchanges, only: [:new, :destroy]
    resources :deliveries, only: [:update]
    resources :addresses, only: [:new, :create, :edit, :update, :destroy]
    resources :boxes, only: [:edit, :update]
  end

    get 'exchanges/load_boxes', to: 'exchanges#load_boxes'

  # Defines the root path route ("/")
  # root "posts#index"
end
