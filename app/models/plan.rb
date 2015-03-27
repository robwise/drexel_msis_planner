# == Schema Information
#
# Table name: plans
#
#  active     :boolean          not null
#  created_at :datetime
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  updated_at :datetime
#  user_id    :integer          not null
#

class Plan < ActiveRecord::Base
  belongs_to :user, inverse_of: :plans
  has_many :planned_courses, dependent: :destroy
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

  def degree_requirement_counts
    requirements = courses.pluck(:degree_requirement)
    counts = {}
    Course.degree_requirements.each do |key, value|
      counts[key.to_sym] = 3 * requirements.count(value)
    end
    counts
  end

  def taken_and_planned_courses
    user.taken_courses.to_a.concat(planned_courses.to_a)
  end

  def requisite_issues
    issues = []
    planned_courses.each do |planned_course|
      course = planned_course.course
      prereq = course.prerequisite
      unless prereq.nil? || prereq.fulfilled?(taken_and_planned_courses)
        issues << "Prerequisite for #{course.full_id} not fulfilled"
      end
    end
    issues
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
