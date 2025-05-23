Rails.application.routes.draw do
  # get 'box_echanges/new'
  devise_for :users, controllers: { registrations: 'users/registrations' }
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

  resources :appellations

  resources :cuvee_colors

  resources :vinyards do
    member do
      get "shipments_csv", to: "vinyards#shipments_to_csv"
      get "pick_ups_csv", to: "vinyards#pick_ups_to_csv"
      get "edit_description", to: "vinyards#edit_description"
      get "edit_region", to: "vinyards#edit_region"
      get "edit_address", to: "vinyards#edit_address"
    end
    resources :dividendes
    resources :dividende_cuvee_colors
    resources :slots
    resources :vinyard_appellations do
      resources :cuvees
      resources :cuvee_colors
    end
  end

  resources :users, only: [:show] do
    resources :exchanges, only: [:index, :create]
    member do
      post "accept", to: "exchanges#accepted_exchanges"
      post "reject", to: "exchanges#rejected_exchanges"
    end
    resources :box_exchanges, only: [:new, :destroy]
    resources :deliveries, only: [:update]
    resources :addresses, only: [:new, :create, :edit, :update, :destroy]
    resources :boxes, only: [:edit, :update] do
      resources :pick_up_dates, only: [:new, :create, :edit, :update]
    end
  end

    get 'exchanges/load_boxes', to: 'exchanges#load_boxes'

  # Defines the root path route ("/")
  # root "posts#index"
end
