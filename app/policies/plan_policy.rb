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
    fail Pundit::NotAuthorizedError, "must be logged in" unless current_user
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
