describe RequisiteCheckService, type: :service do
  let(:taken_course) { build :taken_course }
  let(:other_taken_course) { build :taken_course }
  let(:not_taken_course) { build :course }
  let(:passing_history) { [taken_course, other_taken_course] }
  let(:empty_history) { [(build :taken_course)] }
  let(:single_course_history) { [taken_course] }
  let(:planned_course) { build :planned_course }

  describe "@prerequisite_fulfilled" do
    subject do
      described_class.new(course_history, planned_course).prerequisite_fulfilled
    end
    before { change_prereq_to requisite_for(taken_course) }

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
        change_prereq_to "#{requisite_for(taken_course)} "\
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
        change_prereq_to "#{requisite_for(taken_course)} "\
            "or #{requisite_for(not_taken_course)}"
      end
      context "when only one course exists in history" do
        let(:course_history) { single_course_history }
        it { is_expected.to eq true }
      end
    end
    context "when requisite has parentheses to group an 'or' statement" do
      before do
        change_prereq_to "#{requisite_for(taken_course)} "\
            "and (BLAH 999 Minimum Grade: C or "\
                "#{requisite_for(other_taken_course)})"
      end
      context "when nested 'or' statement should evaluate to true" do
        let(:course_history) { passing_history }
        it { is_expected.to eq true }
      end
    end
    context "when requisite is blank" do
      before { change_prereq_to "" }
      let(:course_history) { empty_history }
      it { is_expected.to eq true }
    end
  end

  private

  def change_prereq_to(prerequisite)
    planned_course.course.prerequisite = prerequisite
  end
end
