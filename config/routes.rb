Rails.application.routes.draw do
  root "messages#index"
  devise_for :users

  mount ActionCable.server => "/cable"

  resources :messages, only: [:create]
end
