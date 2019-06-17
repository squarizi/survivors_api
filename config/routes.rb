Rails.application.routes.draw do
  namespace :v1 do
    resources :survivors, only: [:create, :update_last_location, :exchange_items] do
      post :update_last_location, to: 'survivors#update_last_location', format: :json
      post :exchange_items, to: 'survivors#exchange_items', format: :json
    end
    resources :complaints, only: [:create]
    resources :reports, only: [:index]
  end
end
