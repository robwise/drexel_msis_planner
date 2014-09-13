# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :planned_course do
    plan
    course
    quarter "#{Time.now.year.to_s + [15,25,35,45].sample.to_s }"
  end
end
