describe Plan do
  subject { plan }

  let(:user)             { create(:user) }
  let(:plan)             { build(:plan, user: user) }
  let(:users_other_plan) { build(:plan, user: user) }
  let(:duplicate_plan)   { build(:plan, name: plan.name, user: user) }

  it { should respond_to(:user) }
  it { should respond_to(:name) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_least(1) }
  it { should ensure_length_of(:name).is_at_most(35) }
  it { should respond_to(:planned_courses) }
  it { should belong_to(:user) }
  it { should have_many(:planned_courses).dependent(:destroy) }
  it { should respond_to(:active) }

  describe "with valid attributes" do
    it { should be_valid }
  end

  describe "with taken name" do
    before { duplicate_plan.save }

    it { should be_invalid }
  end

  describe "#active = true" do

    context "when user has no plans" do
      it "should set a new plan to active" do
        expect{ plan.save }.to change(plan, :active).from(false).to(true)
      end
      it "should make user#active_plan return it" do
        expect { plan.save }.to change(user, :active_plan).from(nil).to(plan)
      end
    end

    context "when user's other plan was active" do
      before do
        users_other_plan.active = true
        users_other_plan.save
        plan.active = true
      end

      it "should become the user's new active plan" do
        expect { plan.save }.to change(user, :active_plan).from(users_other_plan).to(plan)
      end
      it "should set user's other plans to false" do
        expect { plan.save; users_other_plan.reload }
          .to change(users_other_plan, :active).from(true).to(false)
      end
    end
  end

end
