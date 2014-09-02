# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :planned_course do
    plan
    course
    quarter 201615
  end
end
