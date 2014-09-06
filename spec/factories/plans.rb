# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    user
    sequence(:name) { |n| "TestPlan#{n}" }
  end
end
