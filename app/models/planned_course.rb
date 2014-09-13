class PlannedCourse < ActiveRecord::Base
  validates :plan, presence: true
  validates :course, presence: true
  validate :quarter_code_validator,
    unless: Proc.new { quarter.nil? },
    on: [:create, :update]
  belongs_to :plan
  belongs_to :course

  def assigned?
    not quarter.nil?
  end

  private

    # In Progress...
    def quarter_code_validator
      if quarter.nil?
        errors.add(:quarter, "cannot be nil")
        return false
      end
      quarter_object = Quarter.new(quarter)
      if quarter_object.valid?
        if quarter_object.to_date > Time.now
          return true
        else
          errors.add(:quarter, "cannot be in the past.")
          return false
        end
      else
        errors.add(:quarter, "is not a valid quarter code")
        return false
      end
    end

end
