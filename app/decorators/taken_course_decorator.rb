class TakenCourseDecorator
  attr_reader :taken_course

  def initialize(taken_course)
    @taken_course = taken_course
  end

  def method_missing(method_name, *args, &block)
    @taken_course.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    @taken_course.respond_to?(method_name, include_private) || super
  end

  def submit_text
    @taken_course.new_record? ? "Add" : "Update"
  end

  def modal_title
    if @taken_course.new_record?
      "Add #{@taken_course.course.full_id}:
        #{@taken_course.course.title.titleize} to Taken Courses"
    else
      "Edit when you took #{@taken_course.course.full_id}:
        #{@taken_course.course.title.titleize}"
    end
  end

  def form_model
    if @taken_course.new_record?
      [@taken_course.user, @taken_course]
    else
      @taken_course
    end
  end
end
