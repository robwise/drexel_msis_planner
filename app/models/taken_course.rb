class TakenCourse < ActiveRecord::Base
  enum grade: ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D",
               "D-", "F", "Withdrew", "Incomplete", "In Progress", "Registered"]
  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :grade, presence: true
  validates :quarter, presence: true
  validate :valid_quarter_code?,
           unless: proc { quarter.nil? } # HACK: for shoulda matcher
  validates :user, uniqueness: { scope: :course }, on: [:create, :update]

  belongs_to :user
  belongs_to :course

  def self.already_taken?(user, course)
    TakenCourse.find_by(user_id: user.id, course_id: course.id).present?
  end

  private

  def valid_quarter_code?
    quarter_object = Quarter.new(quarter)
    if !quarter_object.valid?
      errors.add(:quarter, "is not a valid quarter code")
    elsif quarter_object.to_date > Time.now
      errors.add(:quarter, "cannot be in the future.")
    end
  end
end
