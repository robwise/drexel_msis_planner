# == Schema Information
#
# Table name: users
#
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  created_at             :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  id                     :integer          not null, primary key
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  role                   :integer
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string(255)
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :vip, :admin]

  after_initialize :set_default_role, if: :new_record?

  has_many :taken_courses, dependent: :destroy
  has_many :courses, through: :taken_courses
  has_many :plans,
           -> { order "name ASC" },
           inverse_of: :user,
           dependent: :destroy

  Course.degree_requirements.keys.each do |requirement|
    define_method "#{ requirement }_credits_earned" do
      courses.where(degree_requirement: Course.degree_requirements[requirement])
        .count * 3
    end
  end

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

  private

  def set_default_role
    self.role ||= :user
  end
end
