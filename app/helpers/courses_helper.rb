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

  def show_new_taken_course_button?(course)
    course_ids = current_user ? current_user.course_ids : []
    !course_ids.include?(course.id)
  end
end
