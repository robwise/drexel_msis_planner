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

  def taken_course_button(user, plan, course)
    if course_taken?(user, course) && !course_planned?(plan, course)
      return taken_button(user, course)
    elsif course_planned?(plan, course)
      return disabled_add_to_taken_button
    else
      return enabled_add_to_taken_button(user, course)
    end
  end

  def planned_course_button(user, plan, course)
    if course_planned?(plan, course)
      return planned_button(plan, course)
    elsif plan.nil? || course_taken?(user, course)
      return disabled_add_to_plan_button
    else
      return enabled_add_to_plan_button(plan, course)
    end
  end

  private

  def course_taken?(user, course)
    user.course_ids.include?(course.id)
  end

  def course_planned?(plan, course)
    !plan.nil? && plan.planned_courses_course_ids.include?(course.id)
  end

  def taken_button(user, course)
    button_to "taken",
              path_to_taken_course(user, course),
              method: :delete,
              class: "btn btn-default courses-taken-course-button"
  end

  def enabled_add_to_taken_button(user, course)
    button_to "add to taken",
              new_user_taken_course_path(user_id: user.id, course_id: course.id),
              remote: true,
              method: :get,
              class: "btn btn-primary courses-taken-course-button"
  end

  def disabled_add_to_taken_button
    content_tag :button,
                "add to taken",
                disabled: true,
                class: "btn btn-default courses-taken-course-button"
  end

  def planned_button(plan, course)
    button_to "planned",
              path_to_planned_course(plan, course),
              method: :delete,
              class: "btn btn-default courses-planned-course-button"
  end

  def enabled_add_to_plan_button(plan, course)
    button_to "add to plan",
              new_plan_planned_course_path(plan_id: plan.id, course_id: course.id),
              remote: true,
              method: :get,
              class: "btn btn-primary courses-planned-course-button"
  end

  def disabled_add_to_plan_button
    content_tag :button,
                "add to plan",
                disabled: true,
                class: "btn btn-default courses-planned-course-button"
  end

  def show_new_course_button_if_admin
    return unless current_user.present? && current_user.admin?
    link_to "+", new_course_path
  end

  def degree_requirement_for(course)
    course.degree_requirement.humanize.downcase
  end

  def path_to_taken_course(user, course)
    match = user.taken_courses.detect do |taken_course|
      taken_course.course_id == course.id
    end
    taken_course_path(match)
  end

  def path_to_planned_course(plan, course)
    match = plan.planned_courses.detect do |planned_course|
      planned_course.course_id == course.id
    end
    planned_course_path(match)
  end
end
