class PlanPolicy
  class Scope
    attr_reader :current_user, :plans

    def initialize(current_user, plans)
      @current_user = current_user
      @plans = plans
    end

    def resolve
      if @current_user.nil?
        nil
      elsif @current_user.admin?
        @plans.all
      else
        @plans.where(user: @current_user)
      end
    end
  end

  attr_reader :current_user, :plan

  def initialize(current_user, model)
    # TODO: reimplement belwo when pundit is fixed
    # fail Pundit::NotAuthorizedError, "user not logged in" if current_user.nil?
    fail Pundit::NotAuthorizedError if current_user.nil?
    @current_user = current_user
    @plan = model
  end

  def index?
    true # just checks that user is signed in (via initialize)
  end

  def new?
    @plan.user_id == @current_user.id || @current_user.admin?
  end

  def edit?
    @plan.user_id == @current_user.id || @current_user.admin?
  end

  def create?
    @plan.user_id == @current_user.id || @current_user.admin?
  end

  def update?
    @plan.user_id == @current_user.id || @current_user.admin?
  end

  def destroy?
    @plan.user_id == @current_user.id || @current_user.admin?
  end

  def planner?
    @plan.user_id == @current_user.id || @current_user.admin?
  end
end
