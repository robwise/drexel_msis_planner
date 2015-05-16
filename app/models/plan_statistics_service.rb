class PlanStatisticsService < UsersDegreeStatistics # UsersPlanStatistics
  def initialize(plan)
    super(plan.user)
    @planned_courses_ary = plan.planned_courses.to_a
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

  def any_planned_courses?
    !@planned_courses_ary.empty?
  end

  # how many quarters until last planned quarter
  def quarters_remaining
    return "Degree Completed" if degree_completed?
    return_block_or_error_message do
      Quarter.num_quarters_between(first_planned_quarter, last_planned_quarter)
    end
  end

  def planned_completion_date
    return_block_or_error_message do
      return last_taken_quarter.to_date(true) if degree_completed?
      last_planned_quarter.to_date(true)
    end
  end

  def planned_completion_date_pretty
    return_block_or_error_message do
      planned_completion_date.to_datetime.strftime("%B %Y")
    end
  end

  def first_planned_quarter
    find_min_or_max_in_courses(:min, @planned_courses_ary)
  end

  def last_planned_quarter
    find_min_or_max_in_courses(:max, @planned_courses_ary)
  end

  def all_courses_ary
    @taken_courses_ary + @planned_courses_ary
  end

  def problems_count
    counter = 0
    @planned_courses_ary.each do |planned_course|
      problems_ary = planned_course.requisite_issues(all_courses_ary)
      counter += 1 if problems_ary.size != 0
    end
    counter
  end

  private

  def return_block_or_error_message(&block)
    return "No Courses Planned" if first_planned_quarter.nil? && !degree_completed?
    return "Requirements Not Met" unless degree_completed?
    block.call
  end
end
