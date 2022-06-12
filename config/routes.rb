Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'datasets#index'

  resources :datasets, only: [:index, :show] do
    resources :images, only: [:show]
  end
end
