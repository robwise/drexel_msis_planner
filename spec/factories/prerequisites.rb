FactoryGirl.define do
  factory :prerequisite do
    association :requiring_course, factory: :course
    raw_text { "BLAH 999 Minimum Grade: C" }
  end
end
