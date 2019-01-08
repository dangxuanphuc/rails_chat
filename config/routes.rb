Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  resources :conversations, only: [:create] do
    resources :messages, only: [:create]

    member do
      post :close
    end
  end
end
