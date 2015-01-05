Rails.application.routes.draw do
  resources :summoner_tracker, only: [:index, :new, :create, :destroy]

  resources :summoners, only: [:index, :show]

  devise_for :users
  root to: 'home#show'
end
