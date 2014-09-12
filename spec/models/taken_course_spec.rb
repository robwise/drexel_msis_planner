require_relative './shared/shared_examples_for_quarter_validator'
describe TakenCourse do
  let(:user) { create(:user) }
  let(:course) { create(:course) }
  subject(:taken_course) { build(:taken_course, user_id: user.id,
                                             course_id: course.id) }

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
  it_should_behave_like 'an object with a quarter code'do
    let(:model_with_quarter) { build(:planned_course) }
  end
  describe "associations" do
    before { taken_course.save }

    it "should be able retrieve its user" do
      expect(taken_course.user).to eq(user)
    end
    it "should be able retrieve its course" do
      expect(taken_course.course).to eq(course)
    end
  end

  describe "#self.already_taken?" do
    before { taken_course.save }
    it "should find the matching taken_course" do
      expect(TakenCourse.already_taken?(user, course)).to eq(true)
    end
  end

  describe "updating" do
    before do
      taken_course.quarter = 201415
      taken_course.save
    end
    context "with new quarter of '201815'" do
      it "should return '201815' as its quarter" do
        expect do
          taken_course.update(quarter: 201425)
          taken_course.reload
        end.to change(taken_course, :quarter)
      end
    end
    context "with new grade of 'C'" do
      it "should return 'C' as its grade" do
        expect do
          taken_course.update(grade: 'C')
          taken_course.reload
        end.to change(taken_course, :grade)
      end
    end
  end

end
