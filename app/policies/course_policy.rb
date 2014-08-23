class CoursePolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @course = model
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user.admin?
  end

  def create?
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user.admin?
  end

  def edit?
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user.admin?
  end

  def update?
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user.admin?
  end

  def destroy?
    raise Pundit::NotAuthorizedError, "must be logged in" unless current_user
    @current_user.admin?
  end
end