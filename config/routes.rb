Rails.application.routes.draw do
  root "messages#index"
  devise_for :users

  mount ActionCable.server => "/cable"

  resources :conversations, only: [:create] do
    resources :messages, only: [:create]

    member do
      post :close
    end
  end
end
