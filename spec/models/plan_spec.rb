describe Plan do
  let!(:user) { create(:user) }
  let(:plan) { build(:plan, user: user) }
  let(:users_other_plan) { build(:plan, user: user) }
  let(:planned_course) { build :planned_course, :with_prerequisite, plan: plan }
  let(:taken_course) { build :taken_course, user: user }

  subject(:subject) { plan }

  it { should belong_to(:user) }
  it { should have_many(:planned_courses).dependent(:destroy) }
  it { should have_many(:taken_courses) }
  it { should respond_to(:user) }
  it { should respond_to(:name) }
  it { should respond_to(:active) }
  it { should respond_to(:activate!) }
  it { should respond_to(:planned_courses) }
  it { should respond_to(:courses) }
  it { should respond_to(:taken_and_planned_courses) }
  it { should respond_to(:statistics) }
  it { should respond_to(:taken_courses_course_ids) }
  it { should respond_to(:planned_courses_course_ids) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_least(1) }
  it { should ensure_length_of(:name).is_at_most(35) }

  context "with valid attributes" do
    it { should be_valid }
  end
  context "with taken name" do
    before { create(:plan, name: plan.name, user: user) }
    it { should be_invalid }
  end
  context "being created" do
    it "changes user's number of plans by 1" do
      saving_plan_changes_users_plans_size(plan, 0, 1)
      expect(user.plans.first).to eq(plan)
    end
    context "when user already has another plan" do
      before { users_other_plan.save }
      it "changes user's number of plans from 1 to 2" do
        saving_plan_changes_users_plans_size(plan, 1, 2)
      end
      it "changes user's active plan to the new plan" do
        expect { plan.save }.to change(user, :active_plan)
          .from(users_other_plan).to(plan)
      end
      it "changes the old plan's active attribute to false" do
        expect do
          plan.save
          users_other_plan.reload
        end.to change(users_other_plan, :active).from(true).to(false)
      end
    end
    context "when user has no other plans" do
      it "is set to active" do
        expect { plan.save }.to change(plan, :active).to(true)
      end
      it "becomes user's active plan instead of nil" do
        expect { plan.save }.to change(user, :active_plan).from(nil).to(plan)
      end
    end
    context "when user's other plan was active" do
      before { users_other_plan.save }
      it "becomes user's new active plan" do
        expect { plan.save }.to change(user, :active_plan)
          .from(users_other_plan).to(plan)
      end
      it "sets user's other plans to false" do
        expect do
          plan.save
          users_other_plan.reload
        end.to change(users_other_plan, :active).from(true).to(false)
      end
      it "changes user's total plans count to two" do
        saving_plan_changes_users_plans_size(plan, 1, 2)
      end
    end
  end
  describe "#activate!" do
    context "when other plan was active" do
      before do
        plan.save
        users_other_plan.save
        plan.reload
      end
      it "changes its :active value from false to true" do
        expect do
          plan.activate!
          users_other_plan.reload
          plan.reload
        end.to change(plan, :active).from(false).to(true)
      end
      it "changes the other plan's value from true to false" do
        expect do
          plan.activate!
          users_other_plan.reload
          plan.reload
        end.to change(users_other_plan, :active).from(true).to(false)
      end
    end
  end
  describe "#statistics" do
    it "returns a PlanStatisticsService instance" do
      expect(subject.statistics).to be_a(PlanStatisticsService)
    end
  end
  describe "#taken_courses_course_ids" do
    before do
      taken_course.save
      plan.save
    end
    it "returns each of the plan's user's taken course's course ID" do
      expect(subject.taken_courses_course_ids).to eq [taken_course.course_id]
    end
  end
  describe "#planned_courses_course_ids" do
    before do
      plan.save
      planned_course.save
    end
    it "returns each planned course's course ID" do
      expect(subject.planned_courses_course_ids).to eq [planned_course.course_id]
    end
  end

  private

  def saving_plan_changes_users_plans_size(plan, before_size, after_size)
    expect(user.plans(true).size).to eq(before_size)
    plan.save
    expect(user.plans(true).size).to eq(after_size)
  end
end
