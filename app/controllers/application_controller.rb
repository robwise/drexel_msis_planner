class ApplicationController < ActionController::Base
  # "Lazy Way" of allowing additional parameters for User model
  # with Devise
  before_action :configure_permitted_parameters,
                if: :devise_controller?

  # Loads the user's active plan since it's required on all pages
  before_action :load_users_active_plan

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include PunditHelper

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def load_users_active_plan
    @active_plan = current_user.nil? ? nil : current_user.active_plan
  end
end
