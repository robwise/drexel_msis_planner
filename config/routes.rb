Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users, :courses, :taken_courses, :plans
end
