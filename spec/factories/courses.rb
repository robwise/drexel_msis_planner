# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    department "MyString"
    level 1
    title "MyString"
    description "MyText"
  end
end
