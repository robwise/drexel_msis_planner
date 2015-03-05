# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :taken_course do
    user
    course
    grade "A"
    quarter { (build :past_quarter).code }

    factory :required_taken_course do
      association :course, factory: :course, degree_requirement: :required_course
    end
    factory :distribution_taken_course do
      association :course, factory: :course, degree_requirement: :distribution_requirement
    end
    factory :free_elective_taken_course do
      association :course, factory: :course, degree_requirement: :free_elective
    end
  end
end
