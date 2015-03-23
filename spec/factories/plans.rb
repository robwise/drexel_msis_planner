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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    user
    sequence(:name) { |n| "TestPlan#{n}" }
    trait :deactivated do
      active false
    end
    trait :activated do
      active true
    end
  end
end
