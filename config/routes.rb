Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      jsonapi_resources :films do
        post :submit_rating
      end
    end
  end

  get ':page', to: 'static#show', as: :static
end
