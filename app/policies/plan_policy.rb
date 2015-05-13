class PlanPolicy
  attr_reader :current_user, :plan

  def initialize(current_user, model)
    fail Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user = current_user
    @plan = model
  end

  def index?
    @plan.user == @current_user || @current_user.admin?
  end

  def new?
    true
  end

  def edit?
    @plan.user == @current_user || @current_user.admin?
  end

  def create?
    @plan.user == @current_user || @current_user.admin?
  end

  def update?
    @plan.user == @current_user || @current_user.admin?
  end

  def destroy?
    @plan.user == @current_user || @current_user.admin?
  end
end
