# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :planned_course do
    plan
    association :course
    quarter "#{(Time.zone.now.year + 1).to_s + [15, 25, 35, 45].sample.to_s }"
  end

  trait :required do
    association :course, :required
  end
  trait :distribution do
    association :course, :distribution
  end
  trait :free_elective do
    association :course, :free_elective
  end
  trait :with_prerequisite do
    association :course, :with_prerequisite
  end
end
