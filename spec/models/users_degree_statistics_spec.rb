describe UsersDegreeStatistics, type: :model do
  let(:user) { create :user }
  subject(:subject) { described_class.new(plan) }

  context "with a generic plan" do
    let(:plan) { build_stubbed :plan }
    it { should respond_to(:first_taken_quarter) }
    it { should respond_to(:last_taken_quarter) }
    it { should respond_to(:duration_in_quarters) }
    it { should respond_to(:duration_in_years) }
    it { should respond_to(:required_course_count) }
    it { should respond_to(:required_course_count_needed) }
    it { should respond_to(:distribution_requirement_count) }
    it { should respond_to(:distribution_requirement_count_needed) }
    it { should respond_to(:free_elective_count) }
    it { should respond_to(:free_elective_count_needed) }
    it { should respond_to(:total_credits_count) }
    it { should respond_to(:total_credits_count_needed) }
    it { should respond_to(:all_courses_ary) }
    it { should respond_to(:degree_completed?) }
  end
  context "with multiple planned and taken courses of all types" do
    let(:plan) do
      # NOTE: The fact that there are planned courses shouldn't affect degree
      #       stats. UsersDegreeStatistics only looks at taken courses, as
      #       opposed to PlanStatistics.
      create :plan_with_taken_and_planned_courses,
             planned_required_count: 3,
             planned_distribution_count: 2,
             planned_free_elective_count: 1,
             taken_required_count: 3,
             taken_distribution_count: 2,
             taken_free_elective_count: 1
    end
    describe "#all_courses_ary" do
      it "returns an array consisting of taken courses" do
        return_value = subject.all_courses_ary
        expect(return_value).to be_kind_of(Array)
        expect(return_value.size).to eq 6
      end
    end
    describe "#distribution_requirement_count" do
      it "returns the proper count" do
        expect(subject.distribution_requirement_count).to eq 2
      end
    end
    describe "#distribution_requirement_count_pretty" do
      it "returns the proper count" do
        expect(subject.distribution_requirement_count_pretty).to eq "2/4"
      end
    end
    describe "#distribution_requirement_credits" do
      it "returns the proper number of credits" do
        expect(subject.distribution_requirement_credits).to eq 6
      end
    end
    describe "#free_elective_count" do
      it "returns the proper count" do
        expect(subject.free_elective_count).to eq 1
      end
    end
    describe "#free_elective_count_pretty" do
      it "returns the proper count" do
        expect(subject.free_elective_count_pretty).to eq "1/2"
      end
    end
    describe "#free_elective_credits" do
      it "returns the proper number of credits" do
        expect(subject.free_elective_credits).to eq 3
      end
    end
    describe "#required_course_count" do
      it "returns the proper count" do
        expect(subject.required_course_count).to eq 3
      end
    end
    describe "#required_course_count_pretty" do
      it "returns the proper count" do
        expect(subject.required_course_count_pretty).to eq "3/9"
      end
    end
    describe "#required_course_credits" do
      it "returns the proper number of credits" do
        expect(subject.required_course_credits).to eq 9
      end
    end
    describe "#total_credits_count" do
      it "returns the proper number of credits" do
        expect(subject.total_credits_count).to eq 18
      end
    end
    describe "#total_credits_count_pretty" do
      it "returns the proper number of credits" do
        expect(subject.total_credits_count_pretty).to eq "18/45"
      end
    end
  end
  context "with a plan having courses in specific quarters" do
    let(:plan) do
      create :plan_with_courses_in_specific_quarters,
             first_planned_course_quarter: 201515,
             second_planned_course_quarter: 201635,
             first_taken_course_quarter: 201315,
             second_taken_course_quarter: 201415
    end
    describe "#first_taken_quarter.code" do
      it "returns the proper code" do
        expect(subject.first_taken_quarter.code).to eq 201315
      end
    end
    describe "#last_taken_quarter.code" do
      it "returns the proper code" do
        expect(subject.last_taken_quarter.code).to eq 201415
      end
    end
    describe "#degree_completed?" do
      it "is false" do
        expect(subject.degree_completed?).to eq false
      end
    end
    describe "#duration_in_quarters" do
      it "returns the proper code" do
        expect(subject.duration_in_quarters).to eq "Requirements Not Met"
      end
    end
    describe "#duration_in_years" do
      it "returns the proper code" do
        expect(subject.duration_in_years).to eq "Requirements Not Met"
      end
    end
  end
  context "with no taken courses and 1 planned course" do
    let(:plan) { create :plan }
    let!(:planned_course) { create :planned_course, plan: plan }
    describe "#duration_in_quarters" do
      it "returns the proper duration" do
        expect(subject.duration_in_quarters).to eq "Requirements Not Met"
      end
    end
    describe "#duration_in_years" do
      it "returns the proper duration" do
        expect(subject.duration_in_years).to eq "Requirements Not Met"
      end
    end
  end
  context "with 1 taken course and no planned courses" do
    let(:plan) { create :plan, user: user }
    let!(:taken_course) { create :taken_course, user: user }
    describe "#duration_in_quarters" do
      it "returns the proper duration" do
        expect(subject.duration_in_quarters).to eq "Requirements Not Met"
      end
    end
    describe "#duration_in_years" do
      it "returns the proper duration" do
        expect(subject.duration_in_years).to eq "Requirements Not Met"
      end
    end
  end
  context "with no taken courses and no planned courses" do
    let(:plan) { build_stubbed :plan, user: user }
    describe "#duration_in_quarters" do
      it "returns 'Requirements Not Met'" do
        expect(subject.duration_in_quarters).to eq "Requirements Not Met"
      end
    end
    describe "#duration_in_years" do
      it "returns 'Requirements Not Met'" do
        expect(subject.duration_in_years).to eq "Requirements Not Met"
      end
    end
    describe "#last_taken_quarter" do
      it "returns nil" do
        expect(subject.last_taken_quarter).to be_nil
      end
    end
    describe "#first_taken_quarter" do
      it "returns nil" do
        expect(subject.first_taken_quarter).to be_nil
      end
    end
    describe "#degree_completed?" do
      it "is false" do
        expect(subject.degree_completed?).to eq false
      end
    end
  end
  context "with a completed degree" do
    let(:completion_quarter) { Quarter.current_quarter.previous_quarter }
    let(:plan) do
      create :plan, :completed, last_quarter: completion_quarter.code
    end
    describe "#all_courses_ary" do
      it "returns an array consisting of the taken courses" do
        return_value = subject.all_courses_ary
        expect(return_value).to be_kind_of(Array)
        expect(return_value.size).to eq 15
      end
    end
    describe "#distribution_requirement_count" do
      it "returns the proper count" do
        expect(subject.distribution_requirement_count).to eq 4
      end
    end
    describe "#free_elective_count" do
      it "returns the proper count" do
        expect(subject.free_elective_count).to eq 2
      end
    end
    describe "#required_course_count" do
      it "returns the proper count" do
        expect(subject.required_course_count).to eq 9
      end
    end
    describe "#degree_completed?" do
      it "is true" do
        expect(subject.degree_completed?).to eq true
      end
    end
  end
end
