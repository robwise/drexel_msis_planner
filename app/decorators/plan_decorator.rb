class PlanDecorator
  attr_reader :plan

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
    generate_quarter_sections_for(@plan.user.taken_courses)
  end

  def planned_quarter_sections
    generate_quarter_sections_for(@plan.planned_courses)
  end

  def generate_quarter_sections_for(courses)
    qs_array = []
    quarters = gather_unique_quarters_from(courses)
    quarters.each do |quarter|
      section_title = " (#{quarter}) - " + Quarter.new(quarter).humanize
      qs = { title: section_title }
      qs[:courses] = courses.where(quarter: quarter)
      qs_array << qs
    end
    qs_array
  end

  def submit_text
    if @plan.new_record?
      "Create"
    else
      "Update"
    end
  end

  def form_model
    if @plan.new_record?
      [@plan.user, @plan]
    else
      @plan
    end
  end

  private

  def gather_unique_quarters_from(courses)
    course_quarters = []
    courses.each do |course|
      course_quarters << course.quarter
    end
    course_quarters.uniq.sort
  end
end
