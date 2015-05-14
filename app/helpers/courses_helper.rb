module CoursesHelper
  def requirements
    Course.degree_requirements.collect do |requirement|
      [requirement[0].humanize, requirement[0]]
    end
  end

  def grade_options
    TakenCourse.grades.collect
  end

  def short_name(course)
    course.department + course.level
  end

  def enable_taken_button?(user, active_plan, course)
    !course_taken?(user, course) && (active_plan.nil? || !course_planned?(active_plan, course))
  end

  def enable_add_to_plan_button?(active_plan, course)
    user_signed_in? &&
      !active_plan.nil? &&
      !course_planned?(active_plan, course) &&
      !course_taken?(current_user, course)
  end

  def show_new_course_button_if_admin
    return unless current_user.present? && current_user.admin?
    link_to "+", new_course_path
  end

  def degree_requirement_for(course)
    course.degree_requirement.humanize.downcase
  end

  private

  def course_planned?(plan, course)
    plan.planned_courses_course_ids.include?(course.id)
  end

  def course_taken?(user, course)
    user.course_ids.include?(course.id)
  end
end
