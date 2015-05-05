class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, notice: "User updated."
    else
      redirect_to users_path, alert: "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    if user.destroy
      if current_user.admin?
        redirect_to users_path, notice: "User deleted."
      else
        redirect_to root_url, notice: "Bye! Your account has been successfully
        cancelled. We hope to see you again soon."
      end
    else
      flash.now![:alert] = "Error deleting user."
    end
  end

  private

  def secure_params
    params.require(:user).permit(:role)
  end
end
