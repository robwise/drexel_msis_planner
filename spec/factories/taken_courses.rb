# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :taken_course do
    user_id 1
    course_id 1
    grade 'A'
    quarter 201415
  end
end