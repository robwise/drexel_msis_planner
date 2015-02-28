class ApplicationController < ActionController::Base
  # Loads the user's active plan since it's required on all pages
  before_action :load_users_active_plan

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include PunditHelper

  private

  def load_users_active_plan
    @active_plan = current_user.nil? ? nil : current_user.active_plan
  end
end
