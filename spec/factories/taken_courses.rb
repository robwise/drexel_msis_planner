# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :taken_course do
    user
    course
    grade 'A'
    quarter 201415
  end
end
