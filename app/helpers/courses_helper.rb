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

  def taken?(course, taken_course_ids)
    return if current_user.nil?
    taken_course_ids.include?(course.id)
  end

  def show_new_course_button_if_admin
    return unless current_user.present? && current_user.admin?
    link_to "+", new_course_path
  end

  def degree_requirement_for(course)
    course.degree_requirement.humanize.downcase
  end
end
