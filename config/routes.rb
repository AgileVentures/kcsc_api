Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  scope path: :api do
    mount Ahoy::Engine => "/ahoy"
    resources :analytics, only: :index
  end
end
  