class PlannedCourse < ActiveRecord::Base
  include DelegateToCourse

  validates :plan, presence: true
  validates :course, presence: true
  validates :quarter, presence: true
  validate :valid_planned_quarter?
  belongs_to :plan
  belongs_to :course

  def assigned?
    !quarter.nil?
  end

  private

  def valid_planned_quarter?
    quarter_object = Quarter.new(quarter)
    if !quarter_object.valid?
      errors.add(:quarter, "is not a valid quarter code")
    elsif quarter_object.past?
      errors.add(:quarter, "cannot be in the past.")
    end
  end
end
