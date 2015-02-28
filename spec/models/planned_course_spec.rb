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

  describe "quarter code validation" do
    context "with valid codes" do
      it "should cause it to be valid" do
        good_quarters = [201535, 201545, 201615, 202015]
        good_quarters.each do |good_quarter|
          subject.quarter = good_quarter
          expect(subject).to be_valid
        end
      end
    end
    context "with invalid codes" do
      it "should be cause it to be invalid" do
        bad_quarters = [190015, 201416, 20145, 2014159, 201460, 2014, 201400]
        bad_quarters.each do |bad_quarter|
          subject.quarter = bad_quarter
          expect(subject).not_to be_valid
        end
      end
    end
  end
end
