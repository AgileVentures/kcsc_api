Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  scope path: :api do
    mount Ahoy::Engine => '/ahoy'
    resources :analytics, only: :index
    resources :services, only: :index
    resources :search, only: :create
    resources :articles, only: %i[index show create update]
    resource :app_data, only: %i[show update]
    resources :sections, only: %i[index create update]
    resources :information, only: %i[index create update show]
  end
end
