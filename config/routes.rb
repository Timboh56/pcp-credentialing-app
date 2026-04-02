Rails.application.routes.draw do
  devise_for :users

  # Authenticated root → dashboard; unauthenticated → login
  authenticate :user do
    root "dashboard#index", as: :authenticated_root
  end
  root "devise/sessions#new"

  resources :pcp_credentials

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
