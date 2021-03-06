describe Course do
  subject { course }

  let!(:course) { build(:course) }

  it { should respond_to(:department) }
  it { should respond_to(:level) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:degree_requirement) }
  it { should respond_to(:taken_courses) }
  it { should respond_to(:users) }
  it { should respond_to(:plans) }
  it { should respond_to(:prerequisite) }
  it { should respond_to(:corequisite) }
  it { should validate_presence_of(:department) }
  it { should validate_presence_of(:level) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:degree_requirement) }
  it { should validate_numericality_of(:level).is_greater_than(0) }
  it { should validate_numericality_of(:level).is_less_than(2000) }
  it do
    should define_enum_for(:degree_requirement)
      .with([:required_course, :distribution_requirement, :free_elective])
  end

  describe "validating uniqueness" do
    before { course.save }
    # This needs to go down here because of the way the 'shoulda' uniqueness
    # matcher works.
    it { should validate_uniqueness_of(:title).case_insensitive }
    it do
      should validate_uniqueness_of(:level)
        .scoped_to(:department)
        .with_message("duplicate level for that department")
    end
  end

  context "when another course with same department and level already exists" do
    before do
      create :course, department: course.department, level: course.level
    end
    it "is not valid" do
      expect(subject).to be_invalid
    end
  end

  context "with acceptable attributes" do
    it { should be_valid }
  end

  describe "#destroy" do
    before { course.save }
    it "destroys associated taken_courses" do
      create :taken_course, course: course
      expect { course.destroy }.to change(TakenCourse, :count).by(-1)
    end
    it "destroys associated planned_courses" do
      create :planned_course, course: course
      expect { course.destroy }.to change(PlannedCourse, :count).by(-1)
    end
  end

  describe "#prerequisite" do
    it "returns a blank string if not defined" do
      expect(subject.prerequisite).to eq("")
    end
    it "returns the actual text if defined" do
      attrs = attributes_for :course, :with_prerequisite
      prerequisite_text = attrs[:prerequisite]
      course_with_prereq = described_class.new(attrs)
      expect(course_with_prereq.prerequisite).to eq(prerequisite_text)
      expect { course.save }.not_to change(course_with_prereq, :prerequisite)
    end
    it "strips whitespace" do
      attrs = (attributes_for :course, :with_prerequisite)
      prerequisite_text = attrs[:prerequisite]
      prerequisite_text_with_whitespace = "   #{prerequisite_text}    "
      subject.prerequisite = prerequisite_text_with_whitespace
      expect { subject.save }
        .to change(subject, :prerequisite)
        .from(prerequisite_text_with_whitespace)
        .to(prerequisite_text)
    end
  end
  describe "#corequisite" do
    it "returns a blank string if not defined" do
      expect(subject.corequisite).to eq("")
    end
    it "returns the actual text if defined" do
      attrs = attributes_for :course, :with_corequisite
      corequisite_text = attrs[:corequisite]
      course_with_coreq = described_class.new(attrs)
      expect(course_with_coreq.corequisite).to eq(corequisite_text)
      expect { course.save }.not_to change(course_with_coreq, :corequisite)
    end
    it "strips whitespace" do
      attrs = (attributes_for :course, :with_corequisite)
      corequisite_text = attrs[:corequisite]
      corequisite_text_with_whitespace = "   #{corequisite_text}    "
      subject.corequisite = corequisite_text_with_whitespace
      expect { subject.save }
        .to change(subject, :corequisite)
        .from(corequisite_text_with_whitespace)
        .to(corequisite_text)
    end
  end
end
