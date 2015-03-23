# == Schema Information
#
# Table name: prerequisites
#
#  created_at          :datetime         not null
#  id                  :integer          not null, primary key
#  raw_text            :string           not null
#  requiring_course_id :integer
#  updated_at          :datetime         not null
#

# Prerequisite rules specify the courses that must be taken in a quarter prior
# to taking the requiring course. These prerequisite rules can be complex
# involving and/or logic and grouping via parentheses.
class Prerequisite < ActiveRecord::Base
  belongs_to :requiring_course,
             class_name: "Course",
             foreign_key: "requiring_course_id",
             required: true
  validates :raw_text, presence: true

  # Checks a given course history to ensure the Prerequisite will be fulfilled
  # prior to the requiring course's quarter. Course history here refers to a
  # simple array of TakenCourse and/or PlannedCourse objects, probably passed
  # from a Plan that is checking that courses will be taken in the correct
  # order. We cannot pass normal Course objects directly because they have no
  # associated quarter information.
  def fulfilled?(course_history)
    prior_courses = get_prior_courses(course_history)
    parser = RequisiteParser.new(prior_courses, self)
    parser.fulfilled?
  end

  private

  # Gets all courses corresponding to the given course history excepting those
  # whose quarter is not prior to the requiring course's quarter.
  def get_prior_courses(course_history)
    prior_to_quarter = quarter_of_requiring_course(course_history)
    prior_courses = course_history.select do |historic_course|
      historic_course.quarter < prior_to_quarter
    end
    prior_course_ids = prior_courses.map(&:course_id)
    Course.where(id: prior_course_ids)
  end

  # Finds the requiring course's quarter in the course history
  def quarter_of_requiring_course(course_history)
    course_history.each do |historic_course|
      if historic_course.course_id == requiring_course_id
        return historic_course.quarter
      end
    end
  end
end
