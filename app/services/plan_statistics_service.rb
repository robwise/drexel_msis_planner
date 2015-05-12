require "pry"
class PlanStatisticsService
  attr_reader :taken_courses_ary, :planned_courses_ary

  def initialize(plan)
    @taken_courses_ary = plan.taken_courses.to_a
    @planned_courses_ary = plan.planned_courses.to_a
  end

  # duration for the entire planned degree
  def duration_in_quarters
    return 0 if first_quarter.nil?
    1 + Quarter.num_quarters_between(first_quarter, last_quarter)
  end

  # first quarter of the entire planned degree
  def first_quarter
    return first_taken_quarter if any_taken_courses?
    return first_planned_quarter if any_planned_courses?
    nil
  end

  # last quarter of the entire planned degree
  def last_quarter
    return last_planned_quarter if any_planned_courses?
    return last_taken_quarter if any_taken_courses?
    nil
  end

  def any_taken_courses?
    !taken_courses_ary.empty?
  end

  def any_planned_courses?
    !planned_courses_ary.empty?
  end

  # years (1.0, 1.25, 1.5, 1.75, 2.0, etc.) from first course's quarter to last
  def duration_in_years
    duration_in_quarters.to_f / 4
  end

  # how many quarters until last planned quarter
  def quarters_remaining
    Quarter.num_quarters_between(first_planned_quarter, last_planned_quarter)
  end

  def degree_completed?
    # binding.pry
    required_course_count >= required_course_count_needed &&
      distribution_requirement_count >= distribution_requirement_count_needed &&
      free_elective_count >= free_elective_count_needed
  end

  def planned_completion_date
    return last_taken_quarter.to_date(true) if degree_completed?
    return nil if last_planned_quarter.nil?
    last_planned_quarter.to_date(true)
  end

  def first_planned_quarter
    find_min_or_max_in_courses(:min, @planned_courses_ary)
  end

  def last_planned_quarter
    find_min_or_max_in_courses(:max, @planned_courses_ary)
  end

  def first_taken_quarter
    find_min_or_max_in_courses(:min, @taken_courses_ary)
  end

  def last_taken_quarter
    find_min_or_max_in_courses(:max, @taken_courses_ary)
  end

  def free_elective_count
    degree_requirement_count_in_courses("free_elective",
                                        taken_and_planned_courses)
  end

  def free_elective_count_pretty
    get_pretty_output_for(:free_elective_count)
  end

  def free_elective_credits
    credits_for("free_elective")
  end

  def distribution_requirement_count
    degree_requirement_count_in_courses("distribution_requirement",
                                        taken_and_planned_courses)
  end

  def distribution_requirement_count_pretty
    get_pretty_output_for(:distribution_requirement_count)
  end

  def distribution_requirement_credits
    credits_for("distribution_requirement")
  end

  def required_course_count
    degree_requirement_count_in_courses("required_course",
                                        taken_and_planned_courses)
  end

  def required_course_count_pretty
    get_pretty_output_for(:required_course_count)
  end

  def required_course_credits
    credits_for("required_course")
  end

  def total_credits
    required_course_credits + distribution_requirement_credits +
      free_elective_credits
  end

  def total_credits_pretty
    get_pretty_output_for(:total_credits)
  end

  def taken_and_planned_courses
    @taken_courses_ary + @planned_courses_ary
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

  def total_credits_needed
    Course::TOTAL_CREDITS_TO_GRADUATE
  end

  private

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

  # required_course_count, distribution_requirement_count, free_elective_count
  # total_credits
  def get_pretty_output_for(statistic_type)
    "#{ send(statistic_type) }/#{ send(statistic_type.to_s + '_needed') }"
  end
end
