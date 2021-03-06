require 'sidekiq/web'
Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]

Rails.application.routes.draw do

  namespace :admin do
    get 'login', to: 'sessions#new', as: :login
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy', as: :logout
    resource :account, only: [:edit, :update]
    resources :users, only: [:index, :show]

    root to: 'dashboard#index'
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :lists, only: [:index, :create] do
        resources :should_dos, only: [:update, :index]
      end
      resource :today_list, only: [:show]

      namespace :mine do
        resource :me, only: [:show]
      end
    end
  end



  mount Sidekiq::Web => '/sidekiq'
  mount StatusPage::Engine => '/'
  #mount ActionCable.server => '/cable'
  root to: 'home#index'
end
