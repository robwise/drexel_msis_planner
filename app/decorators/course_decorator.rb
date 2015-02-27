class CourseDecorator
  attr_reader :course, taken_by_current_user

  def initialize(course, taken_by_current_user)
    @course = course
    @taken_by_current_user = taken_by_current_user
  end

  def method_missing(method_name, *args, &block)
    @course.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    @course.respond_to?(method_name, include_private) || super
  end
end
