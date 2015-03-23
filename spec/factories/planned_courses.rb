# == Schema Information
#
# Table name: planned_courses
#
#  course_id  :integer          not null
#  created_at :datetime
#  id         :integer          not null, primary key
#  plan_id    :integer          not null
#  quarter    :integer          not null
#  updated_at :datetime
#

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
end
