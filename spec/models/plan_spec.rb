describe Plan do
  subject { plan }

  let!(:user)             { create(:user) }
  let (:plan)             { build(:plan, user: user) }
  let (:users_other_plan) { build(:plan, user: user) }
  let (:duplicate_plan)   { build(:plan, name: plan.name, user: user) }

  it { should belong_to(:user) }
  it { should have_many(:planned_courses).dependent(:destroy) }
  it { should respond_to(:user) }
  it { should respond_to(:name) }
  it { should respond_to(:active) }
  it { should respond_to(:activate!) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:planned_courses) }
  it { should respond_to(:courses) }
  it { should respond_to(:degree_requirement_counts) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_least(1) }
  it { should ensure_length_of(:name).is_at_most(35) }

  describe "with valid attributes" do
    it { should be_valid }
  end

  describe "with taken name" do
    before { duplicate_plan.save }

    it { should be_invalid }
  end

  describe "creation" do
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

    context "#active = true" do
      context "when user has no other plans" do
        it "sets a new plan to active" do
          expect { plan.save }.to change(plan, :active).to(true)
        end
        it "makes user#active_plan return it" do
          expect { plan.save }.to change(user, :active_plan).from(nil).to(plan)
        end
      end

      context "when user's other plan was active" do
        before { users_other_plan.save }

        it "becomes the user's new active plan" do
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
  end

  describe "#activate!" do
    context "when other plan was active" do
      before do
        plan.save
        users_other_plan.save
        plan.reload
      end
      it "makes the plan active" do
        expect do
          plan.activate!
          users_other_plan.reload
          plan.reload
        end.to change(plan, :active).from(false).to(true)
      end
      it "makes the other plan inactive" do
        expect do
          plan.activate!
          users_other_plan.reload
          plan.reload
        end.to change(users_other_plan, :active).from(true).to(false)
      end
    end
    describe "#degree_requirement_counts" do
      before do
        2.times { create :planned_course, :required, plan: plan }
        3.times do
          create :planned_course,
                 :distribution,
                 plan: plan
        end
        5.times { create :planned_course, :free_elective, plan: plan }
      end
      it "returns the correct amount of credits for each type" do
        counts = plan.degree_requirement_counts
        expect(counts[:required_course]).to eq(6)
        expect(counts[:distribution_requirement]).to eq(9)
        expect(counts[:free_elective]).to eq(15)
      end
    end
  end

  def saving_plan_changes_users_plans_size(plan, before_size, after_size)
    expect(user.plans(true).size).to eq(before_size)
    plan.save
    expect(user.plans(true).size).to eq(after_size)
  end
end
