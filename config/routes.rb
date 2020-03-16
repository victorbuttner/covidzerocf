Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :projects

      root to: "users#index"
    end
  resources :projects
  get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

end
