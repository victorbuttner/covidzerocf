Rails.application.routes.draw do
  
  
  get 'donation_checkout/:id' , to: 'donation_checkout#show', as: 'donation_checkout'
  post 'donation_checkout' , to: 'donation_checkout#create'

  namespace :admin do
      resources :projects

      root to: "projects#index"
    end
  resources :projects do
    resources :donations
  end
  get 'home/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

end
