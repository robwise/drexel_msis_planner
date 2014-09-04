class PlannedCoursePolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if @current_user.admin?
        @klass.all
      else
        @klass.joins(plans).where(plans: { user: @current_user })
      end
    end
  end
end
