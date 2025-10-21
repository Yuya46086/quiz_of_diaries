Rails.application.routes.draw do
  get 'quiz_attempts/new'
  get 'quiz_attempts/create'
  devise_for :users
  root 'dashboards#show'
  resources :posts
  resources :quiz_attempts, only: [:new, :create]
end
