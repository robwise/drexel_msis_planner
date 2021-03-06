class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :vip, :admin]

  after_initialize :set_default_role, if: :new_record?
  validates :name, presence: true

  has_many :taken_courses, dependent: :destroy, inverse_of: :user
  has_many :courses, through: :taken_courses
  has_many :plans,
           -> { order "name ASC" },
           inverse_of: :user,
           dependent: :destroy

  def active_plan
    plans.where(active: true).take
  end

  def enrolled_quarters
    quarters = taken_courses.map(&:quarter)
    quarters.uniq.sort
  end

  def taken_courses_in_quarter(quarter)
    TakenCourse.where(user_id: id, quarter: quarter)
  end

  def total_credits_earned
    taken_courses.size * 3
  end

  # takes either a Course instance or just a Course id
  def course_taken?(course)
    course_id = course.is_a?(Course) ? course.id : course
    taken_courses.any? do |taken_course|
      taken_course.course_id == course_id
    end
  end

  def degree_statistics(reload = false)
    @statistics = UsersDegreeStatistics.new(self) if reload || @statistics.nil?
    @statistics
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
