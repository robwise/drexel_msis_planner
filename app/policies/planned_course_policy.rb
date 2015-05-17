class PlannedCoursePolicy
  attr_reader :current_user, :planned_course

  def initialize(current_user, model)
    # TODO: reimplement belwo when pundit is fixed
    #fail Pundit::NotAuthorizedError, "user must be signed in" unless current_user
    fail Pundit::NotAuthorizedError unless current_user
    @current_user = current_user
    @planned_course = model
  end

  def new?
    (@current_user == @planned_course.plan.user) || current_user.admin?
  end

  def create?
    (@current_user == @planned_course.plan.user) || current_user.admin?
  end

  def update?
    (@current_user == @planned_course.plan.user) || current_user.admin?
  end

  def destroy?
    (@current_user == @planned_course.plan.user) || current_user.admin?
  end
end
