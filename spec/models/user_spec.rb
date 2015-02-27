describe User do
  subject { user }

  let(:user) { build :user }

  it { should respond_to(:email) }
  it { should respond_to(:role) }
  it { should respond_to(:taken_courses) }
  it { should respond_to(:courses) }
  it { should respond_to(:plans) }
  it { should respond_to(:active_plan) }
  it { should respond_to(:has_taken?) }
  it { should respond_to(:taken_quarters) }
  it { should respond_to(:taken_courses_in) }
  it { should respond_to(:required_credits_earned) }
  it { should respond_to(:distribution_credits_earned) }
  it { should respond_to(:free_elective_credits_earned) }
  it { should respond_to(:total_credits_earned) }
  it { should validate_uniqueness_of(:email) }

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
    before do
      user.save
      [201415, 201415, 201425].each do |q|
        create :taken_course, user: user, quarter: q
      end
    end

    it "returns the unique quarters in order" do
      expect(user.taken_quarters).to eq([201415, 201425])
    end
  end

  describe "#taken_courses_in(quarter)" do
    before { user.save }
    let!(:taken_course1) { create :taken_course, user: user, quarter: 201415 }
    let!(:taken_course2) { create :taken_course, user: user, quarter: 201425 }
    let!(:taken_course3) { create :taken_course, user: user, quarter: 201415 }

    it "responds with the courses taken during that quarter" do
      expect(user.taken_courses_in(201415)).to eq([taken_course1, taken_course3])
    end
  end

  describe "credits earned methods" do
    before do
      user.save
      3.times { create :required_taken_course, user: user }
      2.times { create :free_elective_taken_course, user: user }
      create :distribution_taken_course, user: user
    end

    it "respond with proper amount of required credits" do
      expect(user.required_credits_earned).to eq 9
    end
    it "respond with proper amount of distribution credits" do
      expect(user.distribution_credits_earned).to eq 3
    end
    it "respond with proper amount of free elective credits" do
      expect(user.free_elective_credits_earned).to eq 6
    end
    it "respond with proper amount of total credits earned" do
      expect(user.total_credits_earned).to eq 18
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
end
