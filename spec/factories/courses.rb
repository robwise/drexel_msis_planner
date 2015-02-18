# Read about factories at https://github.com/thoughtbot/factory_girl
# include ActiveSupport
require 'faker'

FactoryGirl.define do
  factory :course do
    department "INFO"
    sequence(:level) { |n| n + 400 }
    title { [Faker::Hacker.ingverb, Faker::Hacker.adjective,
           Faker::Hacker.noun.pluralize].join(' ') }
    description Faker::Lorem.paragraph
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
  end
end
