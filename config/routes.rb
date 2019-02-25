Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'events#index'
  
  get '/events/:id/registrations', to: 'events#registrations', as: 'event_registrations'
  get '/events/previous', to: 'events#previous', as: 'previous_events'
  resources :events do
    get '/:event_id/:channel_id', to: 'events#check_channel', as: 'check_channel'
    delete '/:id/image', to: 'events#delete_image', as: 'delete_image'
  end
  
  resources :channels
  resources :bands
  resources :registrations
  resources :users
end
