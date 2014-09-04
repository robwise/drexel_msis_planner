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
    is_logged_in_and_admin
  end

  def create?
    is_logged_in_and_admin
  end

  def edit?
    is_logged_in_and_admin
  end

  def update?
    is_logged_in_and_admin
  end

  def destroy?
    is_logged_in_and_admin
  end

  private

    def is_logged_in_and_admin
      raise Pundit::NotAuthorizedError, "must be logged in" unless @current_user
      @current_user.admin?
    end
end