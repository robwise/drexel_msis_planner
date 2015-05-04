# Read about factories at https://github.com/thoughtbot/factory_girl
# include ActiveSupport
require "faker"

FactoryGirl.define do
  factory :course do
    department "INFO"
    sequence(:level) { |n| n + 400 }
    title do
      [Faker::Hacker.ingverb,
       Faker::Hacker.adjective,
       Faker::Hacker.noun.pluralize].join(" ")
    end
    # Not using Faker in a block will keep giving the same description
    description { Faker::Lorem.paragraph }
    degree_requirement "free_elective"

    trait :required do
      degree_requirement :required_course
    end
    trait :free_elective do
      degree_requirement :free_elective
    end
    trait :distribution do
      degree_requirement :distribution_requirement
    end
    trait :with_prerequisite do
      prerequisite do
        "#{ (build(:course)).full_id } Minimum Grade: C"
      end
    end
    trait :with_unfulfillable_prerequisite do
      prerequisite "BLAH 999 Minimum Grade: C"
    end
    trait :with_corequisite do
      corequisite do
        "#{ (build(:course)).full_id } Minimum Grade: C"
      end
    end
    trait :with_unfulfillable_corequisite do
      corequisite "BLAH 999 Minimum Grade: C"
    end
  end
end
