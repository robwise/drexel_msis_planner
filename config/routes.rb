Rails.application.routes.draw do
  root to: "pages#home", controller: PagesController, action: :get

  devise_for :users
  resources :courses
  shallow do
    resources :users, only: [:index, :show, :update, :destroy] do
      resources :taken_courses, except: [:index, :show]
      resources :plans, only: [:index, :new, :create, :edit, :update, :destroy] do
        resources :planned_courses, only: [:new, :create, :update, :destroy]
      end
    end
  end
  match "users/:id" => "users#destroy", via: :delete, as: :destroy_user
  match "pages/planner", via: :get, controller: :pages, action: :planner, as: :planner_page
end
