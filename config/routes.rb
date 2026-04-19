Rails.application.routes.draw do
  devise_for :users

  root "pages#home"

  # Named route used for post-login redirect and nav links
  get "/dashboard", to: "dashboard#index", as: :authenticated_root

  # Two-factor email verification
  get  "/verify",        to: "two_factor#show",   as: :two_factor
  post "/verify",        to: "two_factor#verify",  as: :verify_two_factor
  post "/verify/resend", to: "two_factor#resend",  as: :resend_two_factor

  resources :pcp_credentials

  get "up" => "rails/health#show", as: :rails_health_check
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
