Rails.application.routes.draw do
  resources :planned_courses

  root to: 'visitors#index'
  devise_for :users
  resources :users, :courses, :taken_courses, :plans
end
