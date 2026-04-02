Rails.application.routes.draw do
  devise_for :users

  root "pages#home"

  # Named route used for post-login redirect and nav links
  get "/dashboard", to: "dashboard#index", as: :authenticated_root

  resources :pcp_credentials

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
