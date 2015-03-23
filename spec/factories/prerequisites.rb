# == Schema Information
#
# Table name: prerequisites
#
#  created_at          :datetime         not null
#  id                  :integer          not null, primary key
#  raw_text            :string           not null
#  requiring_course_id :integer
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :prerequisite do
    association :requiring_course, factory: :course
    raw_text { "BLAH 999 Minimum Grade: C" }
  end
end
