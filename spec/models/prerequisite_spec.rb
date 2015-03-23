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

describe Prerequisite do
  it { should belong_to(:requiring_course) }
  it { should respond_to(:raw_text) }
  it { should validate_presence_of(:requiring_course) }
  it { should validate_presence_of(:raw_text) }
  it { should respond_to(:fulfilled?).with(1).arguments }

  subject { prerequisite }

  let(:requiring_course) { create :course }
  let(:course_history) do
    prior_course1 = create :course, department: "FOO", level: "401"
    taken_course1 = create :taken_course, course: prior_course1
    prior_course2 = create :course, department: "FOO", level: "402"
    taken_course2 = create :taken_course, course: prior_course2
    planned_course = create :planned_course, course: requiring_course
    [taken_course1, taken_course2, planned_course]
  end
  let(:prerequisite) do
    create :prerequisite,
           requiring_course: requiring_course,
           raw_text: "FOO 401 Minimum Grade: C"
  end
  let(:unmet_prerequisite) do
    create :prerequisite, requiring_course: requiring_course
  end

  describe "#fulfilled?(course_history)" do
    it "returns true if prior courses meet requirements" do
      expect(prerequisite.fulfilled?(course_history)).to eq true
    end
    it "returns false if prior courses do not meet requirements" do
      expect(unmet_prerequisite.fulfilled?(course_history)).to eq false
    end
  end
end
