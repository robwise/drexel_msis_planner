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
