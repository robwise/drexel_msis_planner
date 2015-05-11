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
  validates :prerequisite, exclusion: { in: [nil] }
  validates :corequisite, exclusion: { in: [nil] }

  has_many :taken_courses, dependent: :destroy, inverse_of: :course
  has_many :users, through: :taken_courses
  has_many :planned_courses, dependent: :destroy, inverse_of: :course
  has_many :plans, through: :planned_courses

  after_initialize :ensure_valid_prerequisite
  before_validation :ensure_valid_prerequisite
  after_initialize :ensure_valid_corequisite
  before_validation :ensure_valid_corequisite

  def self.default_scope
    all.order(department: :asc, level: :asc)
  end

  REQUIRED_COURSE_COURSES_TO_GRADUATE = 9
  DISTRIBUTION_REQUIREMENT_COURSES_TO_GRADUATE = 4
  FREE_ELECTIVE_COURSES_TO_GRADUATE = 2
  TOTAL_CREDITS_TO_GRADUATE = 45

  def full_id
    "#{department} #{level}"
  end

  def short_id
    "#{department}#{level}"
  end

  private

  def ensure_valid_prerequisite
    self.prerequisite ||= ""
    self.prerequisite = prerequisite.strip
  end

  def ensure_valid_corequisite
    self.corequisite ||= ""
    self.corequisite = corequisite.strip
  end
end
