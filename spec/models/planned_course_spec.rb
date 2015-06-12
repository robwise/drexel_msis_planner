describe PlannedCourse do
  let(:course) { create :course }
  let(:user) { create :user }
  let(:plan) { create :plan, user: user }

  subject(:subject) { build :planned_course, course: course, plan: plan }

  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:course) }
  it { should respond_to(:course_id) }
  it { should respond_to(:plan) }
  it { should respond_to(:plan_id) }
  it { should respond_to(:quarter) }
  it { should respond_to(:assigned?) }
  it { should validate_presence_of(:plan) }
  it { should validate_presence_of(:course) }
  it { should validate_presence_of(:quarter) }
  it { should be_valid }

  it_behaves_like "a delegator to its associated course"

  context "with a valid quarter" do
    it "is valid" do
      expect(subject).to be_valid
    end
    context "with an unfulfilled prerequisite" do
      let(:course) { create :course, :with_unfulfillable_prerequisite }
      specify "#requisite_issues returns the appropriate message" do
        requisite_issues = subject.requisite_issues(plan)
        expect(requisite_issues).to be_kind_of(Array)
        expected_prerequisite_message = "#{ course.prerequisite } not fulfilled"
        expect(requisite_issues).to eq [expected_prerequisite_message]
      end
    end
    context "with a fulfilled prerequisite" do
      let(:taken_course) { create :taken_course, user: user }
      let(:course) { create :course, prerequisite: requisite_for(taken_course) }
      specify "#requisite_issues returns the appropriate message" do
        requisite_issues = subject.requisite_issues(plan)
        expect(requisite_issues).to be_kind_of(Array)
        expect(requisite_issues).to be_empty
      end
    end
    context "with an unfulfilled corequisite" do
      let(:course) { create :course, :with_unfulfillable_corequisite }
      specify "#requisite_issues returns the appropriate message" do
        requisite_issues = subject.requisite_issues(plan)
        expect(requisite_issues).to be_kind_of(Array)
        expected_corequisite_message = "#{ course.corequisite } not fulfilled"
        expect(requisite_issues).to eq [expected_corequisite_message]
      end
    end
    context "with a fulfilled corequisite" do
      let(:taken_course) { create :taken_course, user: user }
      let(:course) { create :course, corequisite: requisite_for(taken_course) }
      specify "#requisite_issues returns the appropriate message" do
        requisite_issues = subject.requisite_issues(plan)
        expect(requisite_issues).to be_kind_of(Array)
        expect(requisite_issues).to be_empty
      end
    end
    context "with unfulfilled prerequisite and corequisite" do
      let(:course) do
        create :course,
               :with_unfulfillable_corequisite,
               :with_unfulfillable_prerequisite
      end
      specify "#requisite_issues returns the appropriate message" do
        requisite_issues = subject.requisite_issues(plan)
        expect(requisite_issues).to be_kind_of(Array)
        expected_corequisite_message = "#{ course.corequisite } not fulfilled"
        expected_prerequisite_message = "#{ course.prerequisite } not fulfilled"
        expect(requisite_issues.size).to eq 2
        expect(requisite_issues).to include(expected_prerequisite_message)
        expect(requisite_issues).to include(expected_corequisite_message)
      end
    end
  end
  context "with an invalid quarter" do
    it "is invalid" do
      bad_quarters = [190015, 201416, 20145, 2014159, 201460, 2014, 201400]
      bad_quarters.each do |bad_quarter|
        subject.quarter = bad_quarter
        expect(subject).not_to be_valid
      end
    end
  end
  context "with a past quarter" do
    it "is invalid" do
      subject.quarter = (build :past_quarter).code
      expect(subject).not_to be_valid
    end
  end
  context "with 3 prior existing planned courses for same quarter" do
    before do
      create_list :planned_course,
                  3,
                  plan: plan,
                  quarter: subject.quarter
    end
    it "is invalid" do
      expect(subject).not_to be_valid
    end
  end
end
