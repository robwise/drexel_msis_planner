class PlannedCourse < ActiveRecord::Base
  validates :plan, presence: true
  validates :course, presence: true
  validates :quarter, quarter: true
  belongs_to :plan
  belongs_to :course

  def assigned?
    not quarter.nil?
  end

  private

end
