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

  def show_enabled_taken_button?(user, plan, course)
    !course_taken?(user, course) && (plan.nil? || !course_planned?(plan, course))
  end

  def show_add_to_plan_button?(plan, course)
    user_signed_in? &&
      !plan.nil? &&
      !course_planned?(plan, course) &&
      !course_taken?(current_user, course)
  end

  def show_unplan_button?(plan, course)
    return false if plan.nil?
    course_planned?(plan, course)
  end

  def show_new_course_button_if_admin
    return unless current_user.present? && current_user.admin?
    link_to "+", new_course_path
  end

  def degree_requirement_for(course)
    course.degree_requirement.humanize.downcase
  end

  def path_to_planned_course(plan, course)
    match = plan.planned_courses.detect do |planned_course|
      planned_course.course_id = course.id
    end
    planned_course_path(match)
  end

  def course_planned?(plan, course)
    plan.planned_courses_course_ids.include?(course.id)
  end

  def course_taken?(user, course)
    user.course_ids.include?(course.id)
  end
end
