class EnrolledIn < ActiveRecord::Base
  enum grade: ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D',
               'D-', 'F', 'Withdrew', 'Incomplete', 'In Progress', 'Registered']
  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :grade, presence: true
  validates :quarter, presence: true
  validate :quarter_code_validator, unless: "quarter.nil?" # nil caught elsewhere
  belongs_to :user
  belongs_to :course
  validate :is_unique_validator

  def is_unique_validator
    already_exists = EnrolledIn.find_by(user_id: user_id,
                                        course_id: course_id)
    if already_exists
      errors.add(:course_id, 'already exists for this user')
    end
  end

  def self.already_enrolled?(user, course)
    EnrolledIn.find_by(user_id: user.id, course_id: course.id).nil? ? false : true
  end

  # Quarter codes are YYYY-QQ, where QQ is 15 (Fall), 25 (Winter), 35 (Spring)
  # and 45 (Summer)
  def quarter_code_validator
    year = quarter / 100
    season = (quarter - (year * 100))
    bad_year = (year > (Time.now.year + 1)) || year < 1980
    bad_season = season % 15 > 0 || !season.between?(15, 45)
    bad_length = quarter.to_s.length != 6
    if bad_year || bad_season || bad_length || quarter.nil? || quarter.blank?
      errors.add(:quarter, 'is not a valid quarter code')
    end
  end
end
