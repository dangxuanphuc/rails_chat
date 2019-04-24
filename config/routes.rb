Rails.application.routes.draw do
  root "messages#index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  mount ActionCable.server => "/cable"

  resources :messages
end
