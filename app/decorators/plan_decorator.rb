class PlanDecorator
  include ActionView::Helpers::TagHelper

  def initialize(plan)
    @plan = plan
  end

  def method_missing(method_name, *args, &block)
    @plan.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    @plan.respond_to?(method_name, include_private) || super
  end

  def taken_quarter_sections
    return [] unless statistics.any_taken_courses?
    first = statistics.first_taken_quarter
    last = statistics.last_taken_quarter
    quarters = Quarter.from(first: first, last: last)
    generate_quarter_sections_for(quarters, taken_courses)
  end

  def planned_quarter_sections
    return [] unless statistics.any_planned_courses?
    last_taken_quarter = statistics.last_taken_quarter
    if last_taken_quarter.nil?
      first = statistics.first_planned_quarter
    else
      first = last_taken_quarter.next_quarter
    end
    last = statistics.last_planned_quarter
    quarters = Quarter.from(first: first, last: last)
    generate_quarter_sections_for(quarters, planned_courses)
  end

  def submit_text
    @plan.new_record? ? "Create" : "Update"
  end

  def form_model
    @plan.new_record? ? [@plan.user, @plan] : @plan
  end

  # Takes a symbol or String argument (:required_course, :free_elective,
  # :distribution_course, or :total_credits)
  def progress_bar_for(progress_type)
    numerator = statistics.send(progress_type.to_s + "_count")
    denominator = statistics.send(progress_type.to_s + "_count_needed")
    build_progress_bar(numerator, denominator)
  end

  def get_problems_for(planned_course)
    planned_course.requisite_issues(statistics.taken_and_planned_courses)
  end

  private

  def generate_quarter_sections_for(quarters, courses)
    sections = []
    quarters.each do |quarter|
      section_title = "#{ quarter.humanize } (#{ quarter.code })"
      section = { title: section_title, quarter: quarter.code }
      section[:courses] = find_courses_by_quarter_code(quarter.code, courses)
      sections << section
    end
    sections
  end

  def find_courses_by_quarter_code(code, courses)
    matching_courses = []
    courses.each do |course|
      matching_courses << course if course.quarter == code
    end
    matching_courses
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
