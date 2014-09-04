class Plan < ActiveRecord::Base
  validates :user, presence: true
  validates :name, presence: true, length: { minimum: 1, maximum: 35 }
  before_save :set_active_to_default
  after_save :deactivate_users_other_plans, if: 'active'
  validate :user_has_no_plans_by_same_name,
    unless: "user.nil?" # Hack to avoid a shoulda validation error
  belongs_to :user
  has_many :planned_courses, dependent: :destroy

  private

    def user_has_no_plans_by_same_name
      if user.plans.where(name: name).size > 0
        errors.add(:name, 'already exists for this user')
      end
    end

    def deactivate_users_other_plans
      Plan.where(user: user)
          .where(active: true)
          .where('id != ?', id)
          .update_all(active: false)
    end

    # default to false.
    def set_active_to_default
      if user.plans.size == 0 # If this is going to be user's only plan..
        self.active = true # automatically make it user's active plan
      elsif active.nil? # otherwise, if not defined
        self.active = false # make it false
      end
    end

end
