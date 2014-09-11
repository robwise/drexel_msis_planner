class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.admin?
  end

  def show?
    @current_user.admin? or @current_user == @user
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    not (admin_deleting_himself? or normal_user_deleting_other_user?)
  end

  private

    def admin_deleting_himself?
      @current_user.admin? && (@user == @current_user)
    end

    def normal_user_deleting_other_user?
      (not @current_user.admin?) && (@user != current_user)
    end

end
