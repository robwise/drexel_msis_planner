class TakenCourse < ActiveRecord::Base
  enum grade: ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D',
               'D-', 'F', 'Withdrew', 'Incomplete', 'In Progress', 'Registered']
  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :grade, presence: true
  validates :quarter, presence: true, quarter: true
  validate :is_unique_validator
  belongs_to :user
  belongs_to :course

  def self.already_taken?(user, course)
    TakenCourse.find_by(user_id: user.id, course_id: course.id).present?
  end

  private

    def is_unique_validator
      already_exists = TakenCourse.find_by(user_id: user_id,
                                          course_id: course_id)
      if already_exists
        errors.add(:course_id, 'already exists for this user')
      end
    end

end
