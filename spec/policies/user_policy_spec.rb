describe UserPolicy do
  subject { described_class }

  let(:current_user) { FactoryGirl.build_stubbed :user }
  let(:other_user) { FactoryGirl.build_stubbed :user }
  let(:admin) { FactoryGirl.build_stubbed :user, :admin }
  let(:visitor) { nil }

  permissions :index? do
    it "denies access if not an admin" do
      expect(subject).not_to permit(current_user)
    end
    it "allows access for an admin" do
      expect(subject).to permit(admin, other_user)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your profile" do
      expect(subject).not_to permit(current_user, other_user)
    end
    it "allows you to see your own profile" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to see any profile" do
      expect(subject).to permit(admin, other_user)
    end
  end

  permissions :update? do
    it "prevents updates if not an admin" do
      expect(subject).not_to permit(current_user)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin, other_user)
    end
  end

  permissions :destroy? do
    it "prevents admin from deleting themself" do
      expect(subject).not_to permit(admin, admin)
    end
    it "allows an admin to delete any user" do
      expect(subject).to permit(admin, other_user)
    end
    it "allows a user to delete themself" do
      expect(subject).to permit(current_user, current_user)
    end
  end

  permissions :home? do
    it "allows access for everyone" do
      expect(subject).to permit(visitor)
    end
  end

  permissions :plans_index? do
    it "prevents current user from seeing other users' plans index" do
      expect(subject).not_to permit(current_user, other_user)
    end
    it "allows current user to see their own plans index" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to see any user's plans index" do
      expect(subject).to permit(admin, other_user)
    end
  end
end
