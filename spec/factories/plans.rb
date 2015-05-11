# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :plan do
    user
    sequence(:name) { |n| "TestPlan#{n}" }
    trait :deactivated do
      active false
    end
    trait :activated do
      active true
    end

    factory :plan_with_taken_and_planned_courses do
      transient { planned_distribution_count 2 }
      transient { planned_required_count 3 }
      transient { planned_free_elective_count 1 }
      transient { taken_distribution_count 2 }
      transient { taken_required_count 3 }
      transient { taken_free_elective_count 1 }

      after(:create) do |plan, evaluator|
        create_list(:planned_course,
                    evaluator.planned_distribution_count,
                    :distribution,
                    plan: plan)
        create_list(:planned_course,
                    evaluator.planned_required_count,
                    :required,
                    plan: plan)
        create_list(:planned_course,
                    evaluator.planned_free_elective_count,
                    :free_elective,
                    plan: plan)
        create_list(:taken_course,
                    evaluator.taken_distribution_count,
                    :distribution,
                    user: evaluator.user)
        create_list(:taken_course,
                    evaluator.taken_required_count,
                    :required,
                    user: evaluator.user)
        create_list(:taken_course,
                    evaluator.taken_free_elective_count,
                    :free_elective,
                    user: evaluator.user)
      end
    end

    factory :plan_with_courses_in_specific_quarters do
      transient do
        first_planned_course_quarter { (build :quarter, :future).code }
      end
      transient do
        second_planned_course_quarter { (build :quarter, :future).code }
      end
      transient do
        first_taken_course_quarter { (build :quarter, :past).code }
      end
      transient do
        second_taken_course_quarter { (build :quarter, :past).code }
      end

      after(:create) do |plan, evaluator|
        create_list(:planned_course,
                    1,
                    quarter: evaluator.first_planned_course_quarter,
                    plan: plan)
        create_list(:planned_course,
                    1,
                    quarter: evaluator.second_planned_course_quarter,
                    plan: plan)
        create_list(:taken_course,
                    1,
                    quarter: evaluator.first_taken_course_quarter,
                    user: evaluator.user)
        create_list(:taken_course,
                    1,
                    quarter: evaluator.second_taken_course_quarter,
                    user: evaluator.user)
      end
    end
  end
end
