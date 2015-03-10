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
    first = user.taken_courses.minimum(:quarter)
    last = user.taken_courses.maximum(:quarter)
    quarters = Quarter.from(first: first, last: last)
    generate_quarter_sections_for(quarters, @plan.user.taken_courses)
  end

  def planned_quarter_sections
    first = Quarter.new(user.taken_courses.maximum(:quarter)).next_quarter.code
    last = planned_courses.maximum(:quarter)
    quarters = Quarter.from(first: first, last: last)
    generate_quarter_sections_for(quarters, @plan.planned_courses)
  end

  def generate_quarter_sections_for(quarters, courses)
    # courses = user.taken_courses + planned_courses
    qs_array = []
    quarters.each do |quarter|
      section_title = "#{quarter.code}- " + quarter.humanize
      qs = { title: section_title, code: quarter.code }
      qs[:courses] = courses.where(quarter: quarter.code)
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

  def required_course_credits
    degree_requirement_counts[:required_course]
  end

  def distribution_requirement_credits
    degree_requirement_counts[:distribution_requirement]
  end

  def free_elective_credits
    degree_requirement_counts[:free_elective]
  end

  def total_credits
    required_course_credits + distribution_requirement_credits + free_elective_credits
  end

  private

  def gather_unique_quarters_from(courses)
    Quarter.from(first: courses.minimum(:quarter),
                 last: courses.maximum(:quarter))
  end
end
