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

    def quarter_code_validator
      quarter_object = Quarter.new(quarter)
      if (not quarter_object.valid?)
        errors.add(:quarter, "is not a valid quarter code")
      elsif quarter_object.to_date < Time.now
          errors.add(:quarter, "cannot be in the past.")
      end
    end

end
