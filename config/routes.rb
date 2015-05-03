# == Route Map
#
#                   Prefix Verb   URI Pattern                                   Controller#Action
#                     root GET    /                                             visitors#index
#         new_user_session GET    /users/sign_in(.:format)                      devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                      devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                     devise/sessions#destroy
#            user_password POST   /users/password(.:format)                     devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)                 devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)                devise/passwords#edit
#                          PATCH  /users/password(.:format)                     devise/passwords#update
#                          PUT    /users/password(.:format)                     devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                       devise/registrations#cancel
#        user_registration POST   /users(.:format)                              devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                      devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                         devise/registrations#edit
#                          PATCH  /users(.:format)                              devise/registrations#update
#                          PUT    /users(.:format)                              devise/registrations#update
#                          DELETE /users(.:format)                              devise/registrations#destroy
#        user_confirmation POST   /users/confirmation(.:format)                 devise/confirmations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format)             devise/confirmations#new
#                          GET    /users/confirmation(.:format)                 devise/confirmations#show
#                  courses GET    /courses(.:format)                            courses#index
#                          POST   /courses(.:format)                            courses#create
#               new_course GET    /courses/new(.:format)                        courses#new
#              edit_course GET    /courses/:id/edit(.:format)                   courses#edit
#                   course GET    /courses/:id(.:format)                        courses#show
#                          PATCH  /courses/:id(.:format)                        courses#update
#                          PUT    /courses/:id(.:format)                        courses#update
#                          DELETE /courses/:id(.:format)                        courses#destroy
#       user_taken_courses POST   /users/:user_id/taken_courses(.:format)       taken_courses#create
#    new_user_taken_course GET    /users/:user_id/taken_courses/new(.:format)   taken_courses#new
#        edit_taken_course GET    /taken_courses/:id/edit(.:format)             taken_courses#edit
#             taken_course PATCH  /taken_courses/:id(.:format)                  taken_courses#update
#                          PUT    /taken_courses/:id(.:format)                  taken_courses#update
#                          DELETE /taken_courses/:id(.:format)                  taken_courses#destroy
#     plan_planned_courses POST   /plans/:plan_id/planned_courses(.:format)     planned_courses#create
#  new_plan_planned_course GET    /plans/:plan_id/planned_courses/new(.:format) planned_courses#new
#           planned_course PATCH  /planned_courses/:id(.:format)                planned_courses#update
#                          PUT    /planned_courses/:id(.:format)                planned_courses#update
#                          DELETE /planned_courses/:id(.:format)                planned_courses#destroy
#               user_plans GET    /users/:user_id/plans(.:format)               plans#index
#                          POST   /users/:user_id/plans(.:format)               plans#create
#            new_user_plan GET    /users/:user_id/plans/new(.:format)           plans#new
#                edit_plan GET    /plans/:id/edit(.:format)                     plans#edit
#                     plan GET    /plans/:id(.:format)                          plans#show
#                          PATCH  /plans/:id(.:format)                          plans#update
#                          PUT    /plans/:id(.:format)                          plans#update
#                          DELETE /plans/:id(.:format)                          plans#destroy
#                    users GET    /users(.:format)                              users#index
#                     user GET    /users/:id(.:format)                          users#show
#                          PATCH  /users/:id(.:format)                          users#update
#                          PUT    /users/:id(.:format)                          users#update
#                          DELETE /users/:id(.:format)                          users#destroy
#             destroy_user DELETE /users/:id(.:format)                          users#destroy
#

Rails.application.routes.draw do
  root to: "visitors#index"

  devise_for :users
  resources :courses
  shallow do
    resources :users, only: [:index, :show, :update, :destroy] do
      resources :taken_courses, except: [:index, :show]
      resources :plans do
        resources :planned_courses, only: [:new, :create, :update, :destroy]
      end
    end
  end
  match "users/:id" => "users#destroy", via: :delete, as: :destroy_user
end
