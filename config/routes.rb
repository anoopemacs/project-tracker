Rails.application.routes.draw do
  root to: 'static_pages#root'

  namespace :api, defaults: { format: :json } do
    resources :projects do
      resources :memberships, only: [:create, :index]
      resources :uploads, except: [:new, :edit, :update]
      resources :tasks, only: [:create, :index]
    end
  end

  resource :session, only: [:new, :create, :destroy]
  resources :users
end
