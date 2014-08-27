describe User do
  it { should respond_to(:email) }
  it { should respond_to(:role) }
  it { should respond_to(:taken_courses) }

  context "with acceptable attributes" do
    let!(:user) { FactoryGirl.build(:user) }
    subject { user }

    it { should be_valid }
  end

end
