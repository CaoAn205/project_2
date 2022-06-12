Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'datasets#index'

  resource :datasets, only: [:index, :show]

  resources :images, only: [:edit]
end
