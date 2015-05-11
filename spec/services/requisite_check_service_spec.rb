describe RequisiteCheckService, type: :service do
  let(:taken_course) { build :taken_course }
  let(:other_taken_course) { build :taken_course }
  let(:not_taken_course) { build :course }
  let(:passing_history) { [taken_course, other_taken_course] }
  let(:empty_history) { [(build :taken_course)] }
  let(:single_course_history) { [taken_course] }
  let(:planned_course) { build :planned_course }

  context "when the target course has a non-blank requisites" do
    let(:required_course) { create :course }
    let(:requiring_course) do
      create :course,
             prerequisite: requisite_for(required_course),
             corequisite: requisite_for(required_course)
    end
    let(:planned_course) { create :planned_course, course: requiring_course }
    describe "#initialize" do
      it "does not change its prerequisite" do
        expect { described_class.new(empty_history, planned_course) }
          .not_to change(planned_course.reload, :prerequisite)
      end
      it "does not change its corequisite" do
        expect { described_class.new(empty_history, planned_course) }
          .not_to change(planned_course.reload, :corequisite)
      end
    end
  end

  shared_examples_for "requisite_fulfilled" do
    context "when course exists in history" do
      let(:course_history) { passing_history }
      it { is_expected.to eq true }
    end
    context "when course does not exist in history" do
      let(:course_history) { empty_history }
      it { is_expected.to eq false }
    end
    context "when requisite has an 'and' term" do
      before do
        change_requisite requisite_type, "#{requisite_for(taken_course)} "\
            "and #{requisite_for(other_taken_course)}"
      end
      context "when both requisite courses exist in history" do
        let(:course_history) { passing_history }
        it { is_expected.to eq true }
      end
      context "when only one of multiple requisite course exists in history" do
        let(:course_history) { single_course_history }
        it { is_expected.to eq false }
      end
    end
    context "when requisite has 'or' term" do
      before do
        change_requisite requisite_type, "#{requisite_for(taken_course)} "\
            "or #{requisite_for(not_taken_course)}"
      end
      context "when only one course exists in history" do
        let(:course_history) { single_course_history }
        it { is_expected.to eq true }
      end
    end
    context "when requisite has parentheses to group an 'or' statement" do
      before do
        change_requisite requisite_type, "#{requisite_for(taken_course)} "\
            "and (BLAH 999 Minimum Grade: C or "\
                "#{requisite_for(other_taken_course)})"
      end
      context "when nested 'or' statement should evaluate to true" do
        let(:course_history) { passing_history }
        it { is_expected.to eq true }
      end
    end
    context "when requisite is blank" do
      before { change_requisite requisite_type, "" }
      let(:course_history) { empty_history }
      it { is_expected.to eq true }
    end
  end

  describe "@prerequisite_fulfilled" do
    let(:requisite_type) { :prerequisite }

    subject do
      described_class.new(course_history, planned_course).prerequisite_fulfilled
    end
    before { change_requisite requisite_type, requisite_for(taken_course) }
    it_should_behave_like "requisite_fulfilled"
    context "when requisite course is being taken during concurrently" do
      let(:course_history) { single_course_history }
      before { taken_course.quarter = planned_course.quarter }
      it { is_expected.to eq false }
    end
  end

  describe "@corequisite_fulfilled" do
    let(:requisite_type) { :corequisite }
    subject do
      described_class.new(course_history, planned_course).corequisite_fulfilled
    end
    before { change_requisite requisite_type, requisite_for(taken_course) }
    it_should_behave_like "requisite_fulfilled"
    context "when requisite course is being taken during concurrently" do
      let(:course_history) { single_course_history }
      before { taken_course.quarter = planned_course.quarter }
      it { is_expected.to eq true }
    end
  end

  private

  # Sends the appropriate method to change the prerequisite or corequisite in
  # question. Allows using shared_examples as long as the let(:requisite_type)
  # is defined accordingly
  def change_requisite(requisite_type, requisite_text)
    planned_course.course.send(requisite_type.to_s + "=", requisite_text)
  end
end
