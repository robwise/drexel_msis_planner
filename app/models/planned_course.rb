class PlannedCourse < ActiveRecord::Base
  validates :plan, presence: true
  validates :course, presence: true
  #validates :quarter, quarter: true
  validate :valid_quarter, unless: Proc.new { quarter.nil? }
  belongs_to :plan
  belongs_to :course

  def assigned?
    not quarter.nil?
  end

  private

    def valid_quarter
      quarter_model = Quarter.new(quarter)
      if quarter_model.valid?
        return true
      else
        errors.add(:quarter, 'is not a valid code.')
        return false
      end
    end

end
