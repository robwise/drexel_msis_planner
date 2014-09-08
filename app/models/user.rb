class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :taken_courses, dependent: :destroy
  has_many :plans, inverse_of: :user, dependent: :destroy

  def active_plan
    plans(true).where(active: true).take
  end

  private
    def set_default_role
      self.role ||= :user
    end

end
