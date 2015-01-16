class Course < ActiveRecord::Base
  enum degree_requirement: [:required_course,
                            :distribution_requirement,
                            :free_elective]
  validates :department, presence: true
  validates :level,
            presence: true,
            numericality: { greater_than: 0, less_than: 2000 },
            uniqueness: { scope: :department,
                          message: "duplicate level for that department" }
  validates :degree_requirement, presence: true
  validates :description, presence: true
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  has_many :taken_courses, dependent: :destroy
  has_many :planned_courses, dependent: :destroy

  def self.default_scope
    all.order(department: :asc, level: :asc)
  end

  def full_id
    "#{department} #{level}"
  end

  def short_id
    "#{department}#{level}"
  end
end
