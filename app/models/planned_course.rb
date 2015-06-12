class PlannedCourse < ActiveRecord::Base
  include DelegateToCourse

  validates :plan, presence: true
  validates :course, presence: true
  validates :quarter, presence: true
  validate :valid_planned_quarter?
  belongs_to :plan, inverse_of: :planned_courses
  belongs_to :course, inverse_of: :planned_courses

  def assigned?
    !quarter.nil?
  end

  def requisite_issues(plan)
    requisite_check = RequisiteCheckService.new(plan, self)
    issues = []
    unless requisite_check.corequisite_fulfilled
      issues << "#{corequisite} not fulfilled"
    end
    unless requisite_check.prerequisite_fulfilled
      issues << "#{prerequisite} not fulfilled"
    end
    issues
  end

  private

  def valid_planned_quarter?
    quarter_object = Quarter.new(quarter)
    if quarter_object.past?
      errors.add(:quarter, "cannot be in the past.")
    end
    if plan && plan.num_planned_courses_in(quarter) >= 3
      errors.add(:quarter, "already 3 courses planned for this quarter")
    end
    rescue ArgumentError
      errors.add(:quarter, "is not a valid quarter code")
  end
end
