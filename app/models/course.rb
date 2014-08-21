class Course < ActiveRecord::Base
  enum degree_requirement: [:required_course, :distribution_requirement,
                            :free_elective]
  validates :department, presence: true
  validates :level, presence: true,
                    numericality: { greater_than: 0, less_than: 2000 }
  validates :degree_requirement, presence: true

  def full_id
    "#{department} #{level}"
  end
end