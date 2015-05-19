module ButtonsHelper
  def taken_course_button(user, plan, course)
    if user.course_taken?(course)
      return taken_button(user, course)
    elsif !plan.nil? && plan.course_planned?(course)
      return disabled_add_to_taken_button
    else
      return enabled_add_to_taken_button(user, course)
    end
  end

  def planned_course_button(user, plan, course)
    if !plan.nil? && plan.course_planned?(course)
      return planned_button(plan, course)
    elsif plan.nil? || user.course_taken?(course)
      return disabled_add_to_plan_button
    else
      return enabled_add_to_plan_button(plan, course)
    end
  end

  def taken_button(user, course)
    button_to "taken",
              path_to_taken_course(user, course),
              method: :delete,
              class: "btn btn-default courses-taken-course-button"
  end

  def enabled_add_to_taken_button(user, course)
    button_to "add to taken",
              new_user_taken_course_path(user_id: user.id,
                                         course_id: course.id),
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
              new_plan_planned_course_path(plan_id: plan.id,
                                           course_id: course.id),
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

  private

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
