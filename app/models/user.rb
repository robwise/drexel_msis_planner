class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :taken_courses, dependent: :destroy
  has_many :plans, -> { order "name ASC" }, inverse_of: :user, dependent: :destroy

  def active_plan
    plans(true).where(active: true).take
  end

  def has_taken?(course)
    TakenCourse.where(course_id: course.id, user_id: id).exists?
  end

  def taken_quarters
    quarters = taken_courses.map { |e| e.quarter }
    quarters.uniq.sort
  end

  def taken_courses_in(quarter)
    TakenCourse.where(user_id: id, quarter: quarter)
  end

  def required_credits_earned
    credits = 0
    self.taken_courses.each do |taken_course|
      if (taken_course.course.degree_requirement == "required_course")
        credits += 3
      end
    end
    credits
  end

  def distribution_credits_earned
    credits = 0
    self.taken_courses.each do |taken_course|
      if (taken_course.course.degree_requirement == "distribution_requirement")
        credits += 3
      end
    end
    credits
  end

  def free_elective_credits_earned
    credits = 0
    self.taken_courses.each do |taken_course|
      if (taken_course.course.degree_requirement == "free_elective")
        credits += 3
      end
    end
    credits
  end

  private
    def set_default_role
      self.role ||= :user
    end

end
