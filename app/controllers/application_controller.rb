class ApplicationController < ActionController::Base
  # "Lazy Way" of allowing additional parameters for User model
  # with Devise
  before_action :configure_permitted_parameters,
                if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include PunditHelper

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end
end
