describe User do
  subject { user }

  let(:user) { build :user }

  it { should respond_to(:email) }
  it { should respond_to(:name) }
  it { should respond_to(:role) }
  it { should respond_to(:taken_courses) }
  it { should respond_to(:courses) }
  it { should respond_to(:plans) }
  it { should respond_to(:active_plan) }
  it { should respond_to(:enrolled_quarters) }
  it { should respond_to(:taken_courses_in_quarter) }
  it { should respond_to(:course_taken?) }
  it { should respond_to(:degree_statistics) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:name) }

  context "with acceptable attributes" do
    it { should be_valid }
  end

  describe "#active_plan" do
    let!(:plan) { create :plan, :activated, user: user }
    before { user.save }

    it "returns the user's active plan" do
      expect(user.active_plan.id).to eq(plan.id)
    end
  end

  describe "#enrolled_quarters" do
    before do
      user.save
      [201415, 201415, 201425].each do |q|
        create :taken_course, user: user, quarter: q
      end
    end

    it "returns the unique quarters in order" do
      expect(user.enrolled_quarters).to eq([201415, 201425])
    end
  end

  describe "#taken_courses_in_quarter(quarter)" do
    before { user.save }
    let!(:taken_course1) { create :taken_course, user: user, quarter: 201415 }
    let!(:taken_course2) { create :taken_course, user: user, quarter: 201425 }
    let!(:taken_course3) { create :taken_course, user: user, quarter: 201415 }

    it "responds with the courses taken during that quarter" do
      expect(user.taken_courses_in_quarter(201415))
        .to eq([taken_course1, taken_course3])
    end
  end

  describe "#destroy" do
    before { user.save }
    it "also destroys the user's plans" do
      create :plan, user: user
      expect { user.destroy }.to change(Plan, :count).by(-1)
    end
    it "also destroys the user's planned courses" do
      plan = create :plan, user: user
      create :planned_course, plan: plan
      expect { user.destroy }.to change(PlannedCourse, :count).by(-1)
    end
    it "also destroys the user's taken courses" do
      create :taken_course, user: user
      expect { user.destroy }.to change(TakenCourse, :count).by(-1)
    end
  end

  describe "course_taken?(course)" do
    let(:taken_course) { create :taken_course, user: user }
    before { user.save }
    it "checks whether a given Course id was taken by the user" do
      course_id = taken_course.course_id
      expect(subject.course_taken?(course_id)).to eq true
    end
    it "checks whether a given Course instance was taken by the user" do
      course = taken_course.course
      expect(subject.course_taken?(course)).to eq true
    end
  end

  describe "#degree_statistics" do
    before { user.save }
    context "returns the user's degree statistics" do
      let(:taken_course) { create :taken_course, user: user }
      it "returns the user's degree statistics" do
        expect(subject.degree_statistics).to be_a(UsersDegreeStatistics)
      end
    end
    context "with no taken courses" do
      let(:taken_course) { create :taken_course, user: user }
      it "returns the user's degree statistics" do
        expect(subject.degree_statistics).to be_a(UsersDegreeStatistics)
      end
    end
  end
end
