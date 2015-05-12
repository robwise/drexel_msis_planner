describe PlanStatisticsService, type: :service do
  let(:user) { create :user }
  subject(:subject) { described_class.new(plan) }

  context "with a generic plan" do
    let(:plan) { build :plan }
    it { should respond_to(:quarters_remaining) }
    it { should respond_to(:planned_completion_date) }
    it { should respond_to(:first_planned_quarter) }
    it { should respond_to(:last_planned_quarter) }
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
    it { should respond_to(:total_credits) }
    it { should respond_to(:total_credits_needed) }
    it { should respond_to(:taken_and_planned_courses) }
    it { should respond_to(:degree_completed?) }
  end

  context "with multiple planned and taken courses of all types" do
    let(:plan) do
      create :plan_with_taken_and_planned_courses,
             planned_distribution_count: 2,
             planned_required_count: 3,
             planned_free_elective_count: 1,
             taken_distribution_count: 2,
             taken_required_count: 3,
             taken_free_elective_count: 1
    end
    describe "#taken_and_planned_courses" do
      it "returns an array consisting of both taken and planned courses" do
        return_value = subject.taken_and_planned_courses
        expect(return_value).to be_kind_of(Array)
        expect(return_value.size).to eq 12
      end
    end
    describe "#distribution_requirement_count" do
      it "returns the proper count" do
        expect(subject.distribution_requirement_count).to eq 4
      end
    end
    describe "#distribution_requirement_count_pretty" do
      it "returns the proper count" do
        expect(subject.distribution_requirement_count_pretty).to eq "4/4"
      end
    end
    describe "#distribution_requirement_credits" do
      it "returns the proper number of credits" do
        expect(subject.distribution_requirement_credits).to eq 12
      end
    end
    describe "#free_elective_count" do
      it "returns the proper count" do
        expect(subject.free_elective_count).to eq 2
      end
    end
    describe "#free_elective_count_pretty" do
      it "returns the proper count" do
        expect(subject.free_elective_count_pretty).to eq "2/2"
      end
    end
    describe "#free_elective_credits" do
      it "returns the proper number of credits" do
        expect(subject.free_elective_credits).to eq 6
      end
    end
    describe "#required_course_count" do
      it "returns the proper count" do
        expect(subject.required_course_count).to eq 6
      end
    end
    describe "#required_course_count_pretty" do
      it "returns the proper count" do
        expect(subject.required_course_count_pretty).to eq "6/9"
      end
    end
    describe "#required_course_credits" do
      it "returns the proper number of credits" do
        expect(subject.required_course_credits).to eq 18
      end
    end
    describe "#total_credits" do
      it "returns the proper number of credits" do
        expect(subject.total_credits).to eq 36
      end
    end
    describe "#total_credits_pretty" do
      it "returns the proper number of credits" do
        expect(subject.total_credits_pretty).to eq "36/45"
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
    describe "#first_planned_quarter.code" do
      it "returns the proper code" do
        expect(subject.first_planned_quarter.code).to eq 201515
      end
    end
    describe "#last_planned_quarter.code" do
      it "returns the proper code" do
        expect(subject.last_planned_quarter.code).to eq 201635
      end
    end
    describe "#quarters_remaining" do
      it "returns the proper number of remaining quarters" do
        expect(subject.quarters_remaining).to eq 6
      end
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
    describe "#planned_completion_date" do
      it "returns date equal to last month of the quarter" do
        expected_date = Date.new(2016, 06)
        expect(subject.planned_completion_date).to eq expected_date
      end
    end
    describe "#degree_completed?" do
      it "is false" do
        expect(subject.degree_completed?).to eq false
      end
    end
    describe "#duration_in_quarters" do
      it "returns the proper code" do
        expect(subject.duration_in_quarters).to eq 15
      end
    end
    describe "#duration_in_years" do
      it "returns the proper code" do
        expect(subject.duration_in_years).to eq 3.75
      end
    end
  end
  context "with no taken courses and 1 planned course" do
    let(:plan) { create :plan }
    let!(:planned_course) { create :planned_course, plan: plan }
    describe "#duration_in_quarters" do
      it "returns the proper duration" do
        expect(subject.duration_in_quarters).to eq 1
      end
    end
    describe "#duration_in_years" do
      it "returns the proper duration" do
        expect(subject.duration_in_years).to eq 0.25
      end
    end
  end
  context "with 1 taken course and no planned courses" do
    let(:plan) { create :plan, user: user }
    let!(:taken_course) { create :taken_course, user: user }
    describe "#duration_in_quarters" do
      it "returns the proper duration" do
        expect(subject.duration_in_quarters).to eq 1
      end
    end
    describe "#duration_in_years" do
      it "returns the proper duration" do
        expect(subject.duration_in_years).to eq 0.25
      end
    end
  end
  context "with no taken courses and no planned courses" do
    let(:plan) { create :plan, user: user }
    describe "#duration_in_quarters" do
      it "returns 0" do
        expect(subject.duration_in_quarters).to eq 0
      end
    end
    describe "#duration_in_years" do
      it "returns 0" do
        expect(subject.duration_in_years).to eq 0
      end
    end
    describe "#last_taken_quarter" do
      it "returns nil" do
        expect(subject.last_taken_quarter).to be_nil
      end
    end
    describe "#last_planned_quarter" do
      it "returns nil" do
        expect(subject.last_planned_quarter).to be_nil
      end
    end
    describe "#first_taken_quarter" do
      it "returns nil" do
        expect(subject.first_taken_quarter).to be_nil
      end
    end
    describe "#first_planned_quarter" do
      it "returns nil" do
        expect(subject.first_planned_quarter).to be_nil
      end
    end
    describe "#planned_completion_date" do
      it "returns nil" do
        expect(subject.planned_completion_date).to be_nil
      end
    end
    describe "#degree_completed?" do
      it "is false" do
        expect(subject.degree_completed?).to eq false
      end
    end
  end
  context "with a completed degree" do
    let(:completion_quarter) { Quarter.current_quarter.previous_quarter! }
    let(:plan) do
      create :plan, :completed, last_quarter: completion_quarter.code
    end
    describe "#degree_completed?" do
      it "is true" do
        expect(subject.degree_completed?).to eq true
      end
    end
    describe "#planned_completion_date" do
      it "returns the date of the last month of the last taken quarter" do
        expect(subject.planned_completion_date)
          .to eq completion_quarter.to_date(true)
      end
    end
    describe "#quarters_remaining" do
      it "returns 0" do
        expect(subject.quarters_remaining).to eq 0
      end
    end
  end
end
