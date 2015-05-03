describe TakenCourse do
  let(:user) { create(:user) }
  let(:course) { create(:course) }
  let(:other_course) { create(:course) }

  subject(:taken_course) do
    build(:taken_course, user_id: user.id, course_id: course.id)
  end

  it { should respond_to(:user_id) }
  it { should respond_to(:course_id) }
  it { should respond_to(:grade) }
  it { should respond_to(:quarter) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:course_id) }
  it { should validate_presence_of(:grade) }
  it { should validate_presence_of(:quarter) }
  it_behaves_like "a delegator to its associated course"
  it_behaves_like "an object with a quarter"

  context "with acceptable attributes" do
    it { should be_valid }
  end
  context "with a past quarter" do
    before { subject.quarter = (build :past_quarter).code }
    it "is valid" do
      expect(subject).to be_valid
    end
  end
  context "with current quarter" do
    before { subject.quarter = (build :current_quarter).code }
    it "is not valid" do
      expect(subject).not_to be_valid
    end
  end
  context "with a future quarter" do
    before { subject.quarter = (build :future_quarter).code }
    it "is not valid" do
      expect(subject).not_to be_valid
    end
  end
  describe "associations" do
    before { taken_course.save }

    it "is able retrieve its user" do
      expect(taken_course.user).to eq(user)
    end
    it "is able retrieve its course" do
      expect(taken_course.course).to eq(course)
    end
  end

  describe "#self.already_taken?" do
    before { taken_course.save }
    it "finds the matching taken_course using objects" do
      expect(described_class.already_taken?(user: user, course: course))
        .to eq(true)
    end
    it "finds the matching taken_course using ids" do
      expect(described_class.already_taken?(user: user.id, course: course.id))
        .to eq(true)
    end
    it "returns false if no match is found" do
      expect(described_class.already_taken?(user: user, course: other_course))
        .to eq(false)
    end
  end

  describe "updating" do
    before do
      taken_course.quarter = 201415
      taken_course.save
    end
    context "with new quarter of '201815'" do
      it "returns '201815' as its quarter" do
        expect do
          taken_course.update(quarter: 201425)
          taken_course.reload
        end.to change(taken_course, :quarter)
      end
    end
    context "with new grade of 'C'" do
      it "returns 'C' as its grade" do
        expect do
          taken_course.update(grade: "C")
          taken_course.reload
        end.to change(taken_course, :grade)
      end
    end
  end
  context "with existing taken courses from user and new course" do
    let!(:existing_taken_course) { create :taken_course, user: user }
    it { should be_valid }
  end
  context "with existing taken courses for course but different user" do
    let!(:existing_taken_course) { create :taken_course, course: course }
    it { should be_valid }
  end
  context "with existing taken course for same course and user" do
    let!(:existing_taken_course) do
      create :taken_course, user: user, course: course
    end
    it { should be_invalid }
  end
end
