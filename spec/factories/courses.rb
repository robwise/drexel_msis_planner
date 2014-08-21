# Read about factories at https://github.com/thoughtbot/factory_girl
# include ActiveSupport

FactoryGirl.define do
  factory :course do
    department "INFO"
    sequence(:level) { |n| n + 529 }
    title Faker::Lorem.words(4).to_s.titleize
    description Faker::Lorem.paragraph
    degree_requirement "free_elective"
  end
end
