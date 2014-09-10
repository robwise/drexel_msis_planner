describe User do
  subject { user }

  let(:user) { FactoryGirl.build(:user) }

  it { should respond_to(:email) }
  it { should respond_to(:role) }
  it { should respond_to(:taken_courses) }
  it { should respond_to(:plans) }
  it { should respond_to(:active_plan) }
  it { should respond_to(:has_taken?) }
  it { should validate_uniqueness_of(:email) }

  context "with acceptable attributes" do
    it { should be_valid }
  end

  describe "#has_taken?(course)" do
    let(:course) { create :course }
    let(:other_course) { create :course }
    let(:taken_course) { create :taken_course, user: user, course: course }
    before do
      user.save
      taken_course.save
    end
    it "is true for course that user has taken" do
      expect(user.has_taken?(course)).to eq(true)
    end
    it "is false for course that user has not taken" do
      expect(user.has_taken?(other_course)).to eq(false)
    end
  end

  xdescribe "#active_plan" do

  end

end
