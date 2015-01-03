class Plan < ActiveRecord::Base
  belongs_to :user, inverse_of: :plans
  has_many :planned_courses, dependent: :destroy

  before_validation :ensure_active_has_value
  before_validation :ensure_active_if_user_has_no_other_plans
  validates :user, presence: true
  validates :name, presence: true, length: { minimum: 1, maximum: 35 },
                 uniqueness: { scope: :user,
                               message: 'a plan with that name already exists' }
  validates :active, presence: true
  after_save :deactivate_users_other_plans, if: 'active = true'

  def activate!
    self.update(active: true)
  end

  private

    # Validators

    def ensure_active_has_value
      self.active = false if active.nil?
      not active.nil?
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
      user.plans.where('id != ?', id) unless user.nil?
    end

    def user_has_other_plans
      users_other_plans.size > 0 unless user.nil?
    end

    def user_has_no_other_plans
      users_other_plans.size == 0 unless user.nil?
    end

end
