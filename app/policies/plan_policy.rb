class PlanPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user = current_user
    @plan = model
  end

  def index?
    true
  end

  def show?
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

  class Scope < Struct.new(:current_user, :model)
    def resolve
      model.where(user_id: current_user.id)
    end
  end
end
