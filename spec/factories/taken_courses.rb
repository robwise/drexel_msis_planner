# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :taken_course do
    user
    course
    grade "A"
    quarter { (build :past_quarter).code }

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
end
