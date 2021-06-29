Rails.application.routes.draw do
  get 'organization_search/create'
  mount_devise_token_auth_for 'User', at: 'api/auth'
  scope path: :api do
    mount Ahoy::Engine => "/ahoy"
    resources :analytics, only: :index
    resources :organizations, only: :index 
    resources :search, only: :create
  end
end
  