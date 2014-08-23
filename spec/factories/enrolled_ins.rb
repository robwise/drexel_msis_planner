# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :enrolled_in do
    user_id 1
    course_id 1
    grade 1
    status 1
    quarter 1
  end
end
