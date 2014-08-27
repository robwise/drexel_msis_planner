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
  context "with bad quarter" do
    it "should be invalid" do
      bad_dates = [190015, 201416, 20145, 2014159, 201460, 2014,
                   201400, nil, ' ']
      bad_dates.each do |bad_date|
        taken_course.quarter = bad_date
        expect(taken_course).not_to be_valid
      end
    end
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

end
