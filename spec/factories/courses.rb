# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    department "INFO"
    level 530
    title "Foundations of Information Systems"
    description "Some text describing the course."
  end
end
