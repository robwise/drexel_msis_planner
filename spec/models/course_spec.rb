describe Course do
  it { should respond_to(:department) }
  it { should respond_to(:level) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:degree_requirement) }
  it { should validate_presence_of(:department) }
  it { should validate_presence_of(:level) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:degree_requirement) }
  it { should validate_numericality_of(:level).is_greater_than(0) }
  it { should validate_numericality_of(:level).is_less_than(2000) }

  context "with acceptable attributes" do
    let!(:course) { FactoryGirl.build(:course) }
    subject { course }

    it { should be_valid }
  end
  context "using a bad format title" do
    let!(:course) { FactoryGirl.create(:course, title: 'wEirD caPitalization') }
    it "should fix it" do
      expect(course.title).to eq("Weird Capitalization")
    end
  end
end