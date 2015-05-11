class PlanDecorator
  include ActionView::Helpers::TagHelper
  attr_reader :plan

  def initialize(plan)
    @plan = plan
    @planned_courses_array = plan.planned_courses.to_a
    @taken_courses_array = plan.taken_courses.to_a
  end

  def method_missing(method_name, *args, &block)
    @plan.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    @plan.respond_to?(method_name, include_private) || super
  end

  def taken_quarter_sections
    first = Quarter.new(statistics.first_taken_quarter)
    last = Quarter.new(statistics.last_taken_quarter)
    quarters = Quarter.from(first: first, last: last)
    generate_quarter_sections_for(quarters, taken_courses)
  end

  def planned_quarter_sections
    first = Quarter.new(statistics.last_taken_quarter).next_quarter.code
    last = Quarter.new(statistics.last_planned_quarter)
    quarters = Quarter.from(first: first, last: last)
    generate_quarter_sections_for(quarters, planned_courses)
  end

  def pretty_planned_completion
    # TODO: add logic if the degree is completed to show that
    planned_completion = statistics.planned_completion_date
    return "No Courses Planned" if planned_completion.nil?
    statistics.planned_completion_date.to_datetime.strftime("%B %Y")
  end

  def pretty_duration
    "#{ statistics.duration_in_quarters } Quarters "\
      "(#{ statistics.duration_in_years } years)"
  end

  def submit_text
    @plan.new_record? ? "Create" : "Update"
  end

  def form_model
    @plan.new_record? ? [@plan.user, @plan] : @plan
  end

  # TODO: move this logic into PlanStatisticsService
  # Takes a symbol or String argument (:required_course, :free_elective,
  # :distribution_course, or :total_credits)
  def progress_bar_for(progress_type)
    progress_type = progress_type.to_s
    if progress_type == "total_credits"
      numerator = @plan.statistics.total_credits
      denominator = Course::TOTAL_CREDITS_TO_GRADUATE
    else
      numerator = @plan.statistics.send("#{progress_type}_count")
      denominator = eval "Course::#{progress_type.upcase}_COURSES_TO_GRADUATE"
    end
    build_progress_bar(numerator, denominator)
  end

  def get_problems_for(planned_course)
    planned_course.requisite_issues(@plan)
  end

  private

  def generate_quarter_sections_for(quarters, courses)
    sections = []
    quarters.each do |quarter|
      section_title = "#{ quarter.humanize } (#{ quarter.code })"
      section = { title: section_title, quarter: quarter.code }
      section[:courses] = courses.where(quarter: quarter.code)
      sections << section
    end
    sections
  end

  def build_progress_bar(numerator, denominator)
    display_value = "#{ numerator }/#{ denominator }"
    value_now = (numerator.to_f / denominator * 100).to_i
    width = "#{value_now}%"
    options = { class: "progress-bar",
                role: "progressbar",
                "aria-valuenow" => value_now,
                "aria-valuemin" => "0",
                "aria-valuemax" => "100",
                style: "min-width: 2em; width: #{ width }" }
    content_tag(:div, display_value, options)
  end

  def gather_unique_quarters_from(courses)
    Quarter.from(first: courses.minimum(:quarter),
                 last: courses.maximum(:quarter))
  end
end
