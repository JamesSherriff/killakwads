Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'events#index'
  
  resources :events do
    delete '/:id/image', to: 'events#delete_image', as: 'delete_image'
  end
  
  resources :channels
  resources :bands
  resources :registrations
  resources :users
end
