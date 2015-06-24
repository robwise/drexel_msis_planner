class PagesController < ApplicationController
  def home
    return unless user_signed_in? # no additional logic needed if not signed in
    authenticate_user!
    @user = current_user
    authorize @user
    @taken_courses = TakenCourse.includes(:course).where(user_id: @user.id)
  end

  def planner # shows the active plan if set, otherwise shows new
    authenticate_user!
    plan = Plan
           .includes(:user, taken_courses: [:course], planned_courses: [:course])
           .find_by(user_id: current_user.id, active: true)
    if plan.nil?
      redirect_to new_user_plan_path(user_id: current_user.id),
                  notice: "Create a plan to begin!"
    else
      authorize plan
      @plan = PlanDecorator.new(plan)
      if @plan.taken_and_planned_courses.size == 0
        flash.now.notice = "You have no courses in your plan. Visit the courses
                           page and add some!"
      end
      render "pages/planner"
    end
  end
end
