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

  def show_new_course_button_if_admin
    return unless current_user.present? && current_user.admin?
    link_to "+", new_course_path
  end

  def degree_requirement_for(course)
    course.degree_requirement.humanize.downcase
  end

  def course_available_class(user, plan, course)
    if !user.nil? && user.course_taken?(course) || (!plan.nil? && plan.course_planned?(course))
      return "unavailable-course"
    else
      return "available-course"
    end
  end
end
