describe Plan do
  let(:user) { build(:user) }
  let(:plan) { build(:plan, user: user) }
  it { should respond_to(:user) }
  it { should respond_to(:name) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:name) }
  it { should ensure_length_of(:name).is_at_least(1) }
  it { should ensure_length_of(:name).is_at_most(35) }

  describe "with taken name" do
    let(:other_plan) { build(:plan, name: plan.name, user: user) }
    before do
      user.save
      plan.save
    end

    it "should not be valid" do
      expect(other_plan).not_to be_valid
    end
  end
end
