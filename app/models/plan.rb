class Plan < ActiveRecord::Base
  validates :user, presence: true
  validates :name, presence: true, length: { minimum: 1, maximum: 35 }
  validate :user_has_no_plans_by_same_name, unless: "user.nil?"
  belongs_to :user
  has_many :planned_courses, dependent: :destroy

  private

    def user_has_no_plans_by_same_name
      user.plans.find_each do |plan|
        if (plan.name == name)
          errors.add(:name, 'already exists for this user')
        end
      end
    end

end
