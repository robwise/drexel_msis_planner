class TakenCoursePolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @taken_course = model
  end

  def new?
    raise Pundit::NotAuthorizedError, "must be logged in" unless @current_user
    true
  end

  def create?
    raise Pundit::NotAuthorizedError, "must be logged in" unless @current_user
    @current_user.admin? || (@current_user.id == @taken_course.user_id)
  end

  def edit?
    raise Pundit::NotAuthorizedError, "must be logged in" unless @current_user
    @current_user.admin? || (@current_user.id == @taken_course.user_id)
  end

  def update?
    raise Pundit::NotAuthorizedError, "must be logged in" unless @current_user
    @current_user.admin? || (@current_user.id == @taken_course.user_id)
  end

  def destroy?
    raise Pundit::NotAuthorizedError, "must be logged in" unless @current_user
    @current_user.admin? || (@current_user.id == @taken_course.user_id)
  end
end