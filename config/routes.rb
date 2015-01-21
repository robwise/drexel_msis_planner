Rails.application.routes.draw do
  root to: "visitors#index"

  devise_for :users
  resources :courses
  shallow do
    resources :users do
      resources :taken_courses, except: [:index, :show]
      resources :plans do
        resources :planned_courses, only: [:create, :update, :destroy]
      end
    end
  end
  match "users/:id" => "users#destroy", via: :delete, as: :destroy_user
end
