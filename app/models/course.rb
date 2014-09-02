class Course < ActiveRecord::Base
  before_create :titleize_title
  enum degree_requirement: [:required_course, :distribution_requirement,
                            :free_elective]
  validates :department, presence: true
  validates :level, presence: true,
                    numericality: { greater_than: 0, less_than: 2000 }
  validates :degree_requirement, presence: true
  validates :description, presence: true
  validates :title, presence: true
  has_many :taken_courses
  has_many :planned_courses, dependent: :destroy

  def full_id
    "#{department} #{level}"
  end

  private
    def titleize_title
      self.title = title.downcase.titleize
    end
end