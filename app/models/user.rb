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
    taken_courses(true).where(course_id: course.id).size > 0
  end

  private
    def set_default_role
      self.role ||= :user
    end

end
