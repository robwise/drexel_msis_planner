class PagesController < ApplicationController
  # before_filter :authenticate_user!

  def home
    if user_signed_in?
      @user = current_user
      authorize @user
    else
      @user = nil
    end
  end
end
