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

  def first_quarter
    return first_taken_quarter if any_taken_courses?
    return first_planned_quarter if any_planned_courses?
    nil
  end

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

  def planned_completion_date
    return nil if last_planned_quarter.nil?
    last_planned_quarter.to_date(true)
  end

  def first_planned_quarter
    min = @planned_courses_ary.min { |a, b| a.quarter <=> b.quarter }
    return nil if min.nil?
    Quarter.new(min.quarter)
  end

  def last_planned_quarter
    max = @planned_courses_ary.max { |a, b| a.quarter <=> b.quarter }
    return nil if max.nil?
    Quarter.new(max.quarter)
  end

  def first_taken_quarter
    min = @taken_courses_ary.min { |a, b| a.quarter <=> b.quarter }
    return nil if min.nil?
    Quarter.new(min.quarter)
  end

  def last_taken_quarter
    max = @taken_courses_ary.max { |a, b| a.quarter <=> b.quarter }
    return nil if max.nil?
    Quarter.new(max.quarter)
  end

  def free_elective_count
    counter = 0
    taken_and_planned_courses.each do |course|
      counter += 1 if course.degree_requirement == "free_elective"
    end
    counter
  end

  def free_elective_count_pretty
    "#{ free_elective_count }/"\
      "#{Course::FREE_ELECTIVE_COURSES_TO_GRADUATE}"
  end

  def free_elective_credits
    free_elective_count * 3
  end

  def distribution_requirement_count
    counter = 0
    taken_and_planned_courses.each do |course|
      counter += 1 if course.degree_requirement == "distribution_requirement"
    end
    counter
  end

  def distribution_requirement_count_pretty
    "#{ distribution_requirement_count }/"\
      "#{Course::DISTRIBUTION_REQUIREMENT_COURSES_TO_GRADUATE}"
  end

  def distribution_requirement_credits
    distribution_requirement_count * 3
  end

  def required_course_count
    counter = 0
    taken_and_planned_courses.each do |course|
      counter += 1 if course.degree_requirement == "required_course"
    end
    counter
  end

  def required_course_count_pretty
    "#{ required_course_count }/"\
      "#{Course::REQUIRED_COURSE_COURSES_TO_GRADUATE}"
  end

  def required_course_credits
    required_course_count * 3
  end

  def total_credits
    required_course_credits + distribution_requirement_credits +
      free_elective_credits
  end

  def total_credits_pretty
    "#{ total_credits }/#{ Course::TOTAL_CREDITS_TO_GRADUATE }"
  end

  def taken_and_planned_courses
    @taken_courses_ary + @planned_courses_ary
  end
end
