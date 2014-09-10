describe Course do
  subject { course }

  let!(:course) { build(:course) }

  it { should respond_to(:department) }
  it { should respond_to(:level) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:degree_requirement) }
  it { should respond_to(:taken_courses) }
  it { should validate_presence_of(:department) }
  it { should validate_presence_of(:level) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:degree_requirement) }
  it { should validate_numericality_of(:level).is_greater_than(0) }
  it { should validate_numericality_of(:level).is_less_than(2000) }

  describe "uniqeness validations" do
    before { course.save }

    it { should validate_uniqueness_of(:title).case_insensitive }
  end

  context "with acceptable attributes" do
    it { should be_valid }
  end

  context "using a bad format title" do
    before { course.title = 'wEirD caPitalization' }

    it "should fix it" do
      course.save
      expect(course.title).to eq("Weird Capitalization")
    end
  end

end