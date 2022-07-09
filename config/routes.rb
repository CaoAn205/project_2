Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'datasets#index'

  resources :datasets, only: [:index, :show] do
    resources :images, only: [:show]
  end

  resources :users, only: [:show]

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        sessions: 'api/v1/sessions',
      }

      resources :users, only: [:index, :show]

      resources :datasets, only: [:index, :show] do
        resources :images, only: [:show]
      end

      namespace :admin do
        resources :users, only: [:create, :destroy]

        resources :datasets, only: [:update, :destroy] do
          resources :labels, only: [:index, :create, :update]
        end
      end

      get '/profile', to: 'profile#index'
      put '/profile/password', to: 'profile#change_password'
      put '/profile/update', to: 'profile#update'

      post "/reset_passwords", to: "reset_passwords#create"
    end
  end
end
