Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "games#index"
  resources :games, only: [:index, :new, :create, :show, :update]
  resources :maps,  only: [:new, :create, :update, :destroy]
end
