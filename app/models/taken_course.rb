# == Schema Information
#
# Table name: taken_courses
#
#  course_id  :integer          not null
#  created_at :datetime
#  grade      :integer          not null
#  id         :integer          not null, primary key
#  quarter    :integer          not null
#  updated_at :datetime
#  user_id    :integer          not null
#

class TakenCourse < ActiveRecord::Base
  enum grade: ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D",
               "D-", "F", "Withdrew", "Incomplete", "In Progress", "Registered"]
  validates :user_id, presence: true
  validates :course_id, presence: true
  validates :grade, presence: true
  validates :quarter, presence: true
  validate :valid_taken_quarter?
  validates :user, uniqueness: { scope: :course }

  belongs_to :user
  belongs_to :course

  def self.already_taken?(args)
    find_by(user: args[:user], course: args[:course]).present?
  end

  private

  def valid_taken_quarter?
    quarter_object = Quarter.new(quarter)
    if !quarter_object.valid?
      errors.add(:quarter, "is not a valid quarter code")
    elsif quarter_object.future?
      errors.add(:quarter, "cannot be in the future.")
    end
  end
end
