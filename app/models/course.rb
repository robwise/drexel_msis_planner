class Course < ActiveRecord::Base
  before_create :titleize_title
  enum degree_requirement: [:required_course, :distribution_requirement,
                            :free_elective]
  validates :department, presence: true
  validates :level, presence: true,
                    numericality: { greater_than: 0, less_than: 2000 }
  validates :degree_requirement, presence: true

  def full_id
    "#{department} #{level}"
  end

  private
    def titleize_title
      self.title = title.downcase.titleize
    end
end