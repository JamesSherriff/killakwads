Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'events#index'
  
  get '/events/previous', to: 'events#previous', as: 'previous_events'
  resources :events do
    resources :result_sets do
      resources :results
    end
    get '/:event_id/:channel_id', to: 'events#check_channel', as: 'check_channel'
    delete '/:id/image', to: 'events#delete_image', as: 'delete_image'
    delete '/:id/pilot_brief', to: 'events#delete_pilot_brief', as: 'delete_pilot_brief'
  end
  get '/events/:id/manage', to: 'events#manage', as: 'manage_event'
  get '/events/:id/registrations', to: 'events#registrations', as: 'event_registrations'
  get '/events/:id/clone', to: 'events#clone', as: 'clone_event'
  
  resources :channels
  resources :bands
  resources :registrations
  resources :users do
    delete '/:id/profile_picture', to: 'users#delete_profile_picture', as: 'delete_profile_picture'
  end
  resources :api
  
  resources :builds, except: [:index, :show]
end
