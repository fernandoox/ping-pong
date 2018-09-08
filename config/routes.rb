Rails.application.routes.draw do
  resources :games

  devise_for :users
  root to: "home#index"
end