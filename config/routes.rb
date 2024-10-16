Rails.application.routes.draw do
  get "pages/home"
  root "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  post "webhook" => "webhook#create"

  resources :tasks
  devise_for :users
end
