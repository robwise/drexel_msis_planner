describe User do
  it { should respond_to(:email) }
  it { should respond_to(:role) }

  context "with acceptable attributes" do
    let!(:user) { FactoryGirl.build(:user) }
    subject { user }

    it { should be_valid }
  end

end
