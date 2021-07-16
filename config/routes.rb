Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        # This doesn't nest within merchants dir
        # and uses the typical items controller,
        # which is probably a good thing since they
        # would be doing duplicate functions
        # NOTE path is still unique
        resources :items, only: [:index]
      end

      resources :items do
        resource :merchant, only: :show
      end
    end
  end
end
