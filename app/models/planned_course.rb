class PlannedCourse < ActiveRecord::Base
  validates :plan, presence: true
  validates :course, presence: true
  validates :quarter, presence: true
  validate :quarter_code_validator,
           unless: proc { quarter.nil? },
           on: [:create, :update]
  belongs_to :plan
  belongs_to :course

  def assigned?
    !quarter.nil?
  end

  private

  def quarter_code_validator
    quarter_object = Quarter.new(quarter)
    if !quarter_object.valid?
      errors.add(:quarter, "is not a valid quarter code")
    elsif quarter_object.to_date < Time.now
      errors.add(:quarter, "cannot be in the past.")
    end
  end
end
