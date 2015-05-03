describe PlannedCourse do
  subject { planned_course }

  let!(:planned_course) { create :planned_course }

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
      subject.quarter = (build :future_quarter).code
      expect(subject).to be_valid
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
end
