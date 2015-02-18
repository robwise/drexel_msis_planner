describe TakenCourse do
  let(:user) { create(:user) }
  let(:course) { create(:course) }

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

  context "with acceptable attributes" do
    it { should be_valid }
  end
  context "with valid quarter code" do
    it "is valid" do
      good_quarters = [201415, 201425, 201435, 201445, 199015]
      good_quarters.each do |good_quarter|
        subject.quarter = good_quarter
        expect(subject).to be_valid
      end
    end
  end
  context "with invalid quarter code" do
    it "is not valid" do
      bad_quarters = [190015, 201416, 20145, 201520, 201460, 2014, 201400]
      bad_quarters.each do |bad_quarter|
        subject.quarter = bad_quarter
        expect(subject).not_to be_valid
      end
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
    it "finds the matching taken_course" do
      expect(described_class.already_taken?(user, course)).to eq(true)
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
end
