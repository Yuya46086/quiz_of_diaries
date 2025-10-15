Rails.application.routes.draw do
  devise_for :users
  root 'dashboards#show'
  resources :posts, only: [:index, :show, :new, :create, :edit, :update]
end
