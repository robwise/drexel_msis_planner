class UsersDegreeStatistics
  def initialize(user)
    @taken_courses_ary = user.taken_courses.to_a
  end

  def all_courses_ary
    @taken_courses_ary
  end

  def any_taken_courses?
    !@taken_courses_ary.empty?
  end

  def first_taken_quarter
    find_min_or_max_in_courses(:min, @taken_courses_ary)
  end

  def last_taken_quarter
    find_min_or_max_in_courses(:max, @taken_courses_ary)
  end

  def free_elective_count
    degree_requirement_count_in_courses("free_elective",
                                        all_courses_ary)
  end

  def free_elective_count_pretty
    get_pretty_output_for(:free_elective_count)
  end

  def free_elective_credits
    credits_for("free_elective")
  end

  def distribution_requirement_count
    degree_requirement_count_in_courses("distribution_requirement",
                                        all_courses_ary)
  end

  def distribution_requirement_count_pretty
    get_pretty_output_for(:distribution_requirement_count)
  end

  def distribution_requirement_credits
    credits_for("distribution_requirement")
  end

  def required_course_count
    degree_requirement_count_in_courses("required_course", all_courses_ary)
  end

  def required_course_count_pretty
    get_pretty_output_for(:required_course_count)
  end

  def required_course_credits
    credits_for("required_course")
  end

  def total_credits_count
    required_course_credits + distribution_requirement_credits +
      free_elective_credits
  end

  def total_credits_count_pretty
    get_pretty_output_for(:total_credits_count)
  end

  def required_course_count_needed
    Course::REQUIRED_COURSE_COURSES_TO_GRADUATE
  end

  def distribution_requirement_count_needed
    Course::DISTRIBUTION_REQUIREMENT_COURSES_TO_GRADUATE
  end

  def free_elective_count_needed
    Course::FREE_ELECTIVE_COURSES_TO_GRADUATE
  end

  def total_credits_count_needed
    Course::TOTAL_CREDITS_TO_GRADUATE
  end

  def degree_completed?
    required_course_count >= required_course_count_needed &&
      distribution_requirement_count >= distribution_requirement_count_needed &&
      free_elective_count >= free_elective_count_needed
  end

  def duration_in_quarters
    return_block_or_error_message do
      1 + Quarter.num_quarters_between(first_quarter, last_quarter)
    end
  end

  # years (1.0, 1.25, 1.5, 1.75, 2.0, etc.)
  def duration_in_years
    return_block_or_error_message { duration_in_quarters.to_f / 4 }
  end

  def duration_pretty
    return "Degree Completed" if degree_completed?
    return_block_or_error_message do
      "#{ duration_in_quarters } Quarters "\
        "(#{ duration_in_years } years)"
    end
  end

  protected

  # required_course_count, distribution_requirement_count, free_elective_count
  # total_credits_count
  def get_pretty_output_for(statistic_type)
    "#{ send(statistic_type) }/#{ send(statistic_type.to_s + '_needed') }"
  end

  def find_min_or_max_in_courses(min_or_max, course_ary)
    result = course_ary.send(min_or_max) { |a, b| a.quarter <=> b.quarter }
    return nil if result.nil?
    Quarter.new(result.quarter)
  end

  def degree_requirement_count_in_courses(degree_requirement, courses_ary)
    counter = 0
    courses_ary.each do |course|
      counter += 1 if course.degree_requirement == degree_requirement.to_s
    end
    counter
  end

  def credits_for(degree_type)
    send(degree_type + "_count") * 3
  end

  def return_block_or_error_message(&block)
    return "Requirements Not Met" unless degree_completed?
    block.call
  end
end
