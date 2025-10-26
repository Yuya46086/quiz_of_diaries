Rails.application.routes.draw do
  get 'rankings/index'
  get 'quiz_attempts/new'
  get 'quiz_attempts/create'
  get 'ranking', to: 'ranking#index', as: 'ranking'
  devise_for :users
  root 'dashboards#show'
  resources :posts
  resources :quiz_attempts, only: [:new, :create]
end
