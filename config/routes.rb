Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # Merchants resources and namespace
      namespace :merchants do
        # Listing these first so :id doesn't override path
        get '/find', to: 'searches#show'
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end

      # Items resources and namespace
      namespace :items do
        # Listing these first so :id doesn't override path
        get '/find_all', to: 'searches#index'
      end

      resources :items do
        resource :merchant, only: :show
      end

    end
  end
end
