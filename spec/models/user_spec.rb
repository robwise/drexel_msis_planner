describe User do
  subject { user }

  let(:user) { build :user }

  it { should respond_to(:email) }
  it { should respond_to(:role) }
  it { should respond_to(:taken_courses) }
  it { should respond_to(:plans) }
  it { should respond_to(:active_plan) }
  it { should respond_to(:has_taken?) }
  it { should respond_to(:taken_quarters) }
  it { should respond_to(:taken_courses_in) }
  it { should validate_uniqueness_of(:email) }

  context "with acceptable attributes" do
    it { should be_valid }
  end

  describe "#active_plan" do
    let!(:plan) { create :plan, :activated, user: user }
    before { user.save }

    it "should return the user's active plan" do
      expect(user.active_plan).to eq(plan)
    end
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

  describe "#taken_quarters" do
    before { user.save }
    let!(:course1) { create :course }
    let!(:course2) { create :course }
    let!(:course3) { create :course }
    let!(:taken_course1) { create :taken_course, user: user, course: course1, quarter: 201415 }
    let!(:taken_course2) { create :taken_course, user: user, course: course2, quarter: 201425 }
    let!(:taken_course3) { create :taken_course, user: user, course: course3, quarter: 201415 }

    it "should return the unique quarters in order" do
      expect(user.taken_quarters).to eq([201415, 201425])
    end
  end

  describe "#taken_courses_in(quarter)" do
    before { user.save }
    let!(:course1) { create :course }
    let!(:course2) { create :course }
    let!(:course3) { create :course }
    let!(:taken_course1) { create :taken_course, user: user, course: course1, quarter: 201415 }
    let!(:taken_course2) { create :taken_course, user: user, course: course2, quarter: 201425 }
    let!(:taken_course3) { create :taken_course, user: user, course: course3, quarter: 201415 }
    it "should respond with the courses taken during that quarter" do
      expect(user.taken_courses_in(201415)).to eq([taken_course1, taken_course3])
    end
  end

end
