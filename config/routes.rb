Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  scope path: :api do
    mount Ahoy::Engine => "/ahoy"
    resources :analytics, only: :index
    resources :services, only: :index 
    resources :search, only: :create
    resources :app_data, only: :index
  end
end
  