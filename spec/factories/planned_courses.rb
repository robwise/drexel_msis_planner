# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :planned_course do
    plan
    association :course

    # all of this nonsense is necessary because we can only have a max of 3
    # planned courses for any given quarter
    sequence(:quarter) do |n|
      candidate_quarter = build :future_quarter
      (n / 3).times do
        candidate_quarter = candidate_quarter.next_quarter
      end
      candidate_quarter.to_s
    end
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
  trait :with_corequisite do
    association :course, :with_corequisite
  end
  trait :with_co_and_prerequisites do
    association :course, :with_corequisite, :with_prerequisite
  end
end
