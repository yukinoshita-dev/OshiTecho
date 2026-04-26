Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :theme, only: [:update]
  resource :registration, only: [:new, :create]
  resource :profile, only: [:edit, :update]
  resources :oshis
  resources :goods
  resources :activity_logs
  resources :events do
    resources :participations, only: [:create, :destroy],
              controller: "event_participations"
  end
  get "users/:username", to: "profiles#show", as: :user_profile
  resources :users, only: [] do
    resource :follow, only: [:create, :destroy], controller: "follows"
    get :following, on: :member
    get :followers, on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  get "dashboard", to: "dashboard#index", as: :dashboard
  root "home#index"
end
