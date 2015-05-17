class TakenCoursePolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    # TODO: reimplement belwo when pundit is fixed
    # raise Pundit::NotAuthorizedError, "user must be signed in" unless current_user
    raise Pundit::NotAuthorizedError unless current_user
    @current_user = current_user
    @taken_course = model
  end

  def new?
    @current_user.admin? || (@current_user.id == @taken_course.user_id)
  end

  def create?
    @current_user.admin? || (@current_user.id == @taken_course.user_id)
  end

  def edit?
    @current_user.admin? || (@current_user.id == @taken_course.user_id)
  end

  def update?
    @current_user.admin? || (@current_user.id == @taken_course.user_id)
  end

  def destroy?
    @current_user.admin? || (@current_user.id == @taken_course.user_id)
  end

end
