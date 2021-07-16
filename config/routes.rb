Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # Merchants resources and namespace
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end

      namespace :merchants do
        get '/find', to: 'searches#show'
      end

      # Items resources and namespace
      resources :items do
        resource :merchant, only: :show
      end

      namespace :items do
        get '/find_all', to: 'searches#index'
      end
    end
  end
end
