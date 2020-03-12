Rails.application.routes.draw do
  devise_for :users

  root "groups#index"
  resources :users, only: [:index, :edit, :update]
  resources :groups, only: [:new, :create, :edit, :update] do
    resources :comments, only: [:index, :create, :show]
    namespace :api do
      resources :comments, only: :index, defaults:{format:'json'}
    end
  end
end
