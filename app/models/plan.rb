class Plan < ActiveRecord::Base
  belongs_to :user, inverse_of: :plans
  has_many :planned_courses, dependent: :destroy, inverse_of: :plan
  has_many :taken_courses, through: :user
  has_many :courses, through: :planned_courses

  before_validation :ensure_active_has_value
  before_validation :ensure_active_if_user_has_no_other_plans
  validates :user, presence: true
  validates :name,
            presence: true,
            length: { minimum: 1, maximum: 35 },
            uniqueness: { scope: :user,
                          message: "a plan with that name already exists" }
  validates :active, presence: true
  after_save :deactivate_users_other_plans, if: "active = true"

  def activate!
    update(active: true)
  end

  def taken_and_planned_courses
    taken_courses.to_a + planned_courses.to_a
  end

  def statistics(reload = false)
    @statistics = PlanStatisticsService.new(self) if reload || @statistics.nil?
    @statistics
  end

  private

  # Validators

  def ensure_active_has_value
    self.active = false if active.nil?
    !active.nil?
  end

  def ensure_active_if_user_has_no_other_plans
    self.active = true if user_has_no_other_plans
    active == true || user_has_other_plans
  end

  def deactivate_users_other_plans
    users_other_plans.where(active: true).update_all(active: false)
  end

  # Helper methods

  def users_other_plans
    user.plans.where("id != ?", id) unless user.nil?
  end

  def user_has_other_plans
    users_other_plans.size > 0 unless user.nil?
  end

  def user_has_no_other_plans
    users_other_plans.size == 0 unless user.nil?
  end
end
