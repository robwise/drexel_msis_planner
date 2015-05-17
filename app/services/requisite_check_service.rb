# Parses a given requisite rule formatted as seen on Drexel's Term Master
# Schedule website to determine whether a given course history (either an
# instance of Plan or an array of objects that respond to :level and :quarter)
# fulfills the requisite.
class RequisiteCheckService
  COURSE_REGEX = /([A-Z]{2,4} \d+ Minimum Grade: C)/
  LEVEL_REGEX = /[A-Z]{2,4} (\d+) Minimum Grade: C/
  DEPARTMENT_REGEX = /([A-Z]{2,4}) \d+ Minimum Grade: C/

  attr_reader :prerequisite_fulfilled, :corequisite_fulfilled

  def initialize(course_history, target_course)
    if course_history.is_a? Plan
      course_history = course_history.taken_and_planned_courses
    end
    @target_course = target_course
    initialize_course_arrays(course_history)
    @prerequisite_fulfilled = check_prerequisite
    @corequisite_fulfilled = check_corequisite
  end

  private

  # We need to constrict our search to courses that are supposedly going to be
  # taken prior to the target course's quarter (or the same quarter if it is a
  # corequisite). This builds such constricted course arrays for us to use.
  def initialize_course_arrays(course_history)
    @courses_prior_to_target = []
    @courses_prior_to_or_concurrent_with_target = []
    course_history.each do |course|
      if course.quarter < @target_course.quarter
        @courses_prior_to_target << course
      end
      if course.quarter <= @target_course.quarter
        @courses_prior_to_or_concurrent_with_target << course
      end
    end
  end

  def check_prerequisite
    check_requisite(@courses_prior_to_target,
                    @target_course.prerequisite)
  end

  def check_corequisite
    check_requisite(@courses_prior_to_or_concurrent_with_target,
                    @target_course.corequisite)
  end

  # HACK: uses 'eval' on a string of true or falses with condtional logic
  def check_requisite(courses, requisite)
    return true if requisite.blank?
    eval get_evaluatable_statement(courses, requisite)
  end

  # HACK: uses regex to replace each requisite course
  # phrase in the requisite text with a string of 'true' or 'false'
  # corresponding to that course's existence in the given course history so that
  # we may call 'eval' on the returned string
  def get_evaluatable_statement(courses, requisite)
    statement = String.new(requisite)
    until statement.match(COURSE_REGEX).nil?
      statement.sub!(COURSE_REGEX) do |course_string|
        department = DEPARTMENT_REGEX.match(course_string)[1]
        level = LEVEL_REGEX.match(course_string)[1]
        requisite_course_taken?(courses, department, level).to_s
      end
    end
    statement
  end

  # Determines whether a course with the given department and level exists in
  # the given courses list
  def requisite_course_taken?(courses, department, level)
    courses.any? do |course|
      course.department == department && course.level.to_s == level
    end
  end
end
