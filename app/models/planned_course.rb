class PlannedCourse < ActiveRecord::Base
  validates :plan, presence: true
  validates :course, presence: true
  validate :valid_quarter, unless: Proc.new { quarter.nil? }
  belongs_to :plan
  belongs_to :course

  def assigned?
    not quarter.nil?
  end

  private

    # In Progress...
    def valid_quarter
      quarter_model = Quarter.new(quarter)
      if quarter_model.valid?
        if quarter.between(Quarter.new())

        end
        return true
      else
        errors.add(:quarter, 'is not a valid code.')
        return false
      end
    end

end
