describe User do
  it { should respond_to(:email) }
  it { should respond_to(:role) }
  it { should validate_uniqueness_of(:email) }
  it { should respond_to(:taken_courses) }
  it { should respond_to(:plans) }
  it { should respond_to(:active_plan) }

  context "with acceptable attributes" do
    let!(:user) { FactoryGirl.build(:user) }
    subject { user }

    it { should be_valid }
  end

end
