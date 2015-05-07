FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    sequence(:email) { |n| "test_user#{n}@example.com" }
    name { email[/(.*)@.*/] }
    password "please123"

    trait :admin do
      role "admin"
    end
  end
end
