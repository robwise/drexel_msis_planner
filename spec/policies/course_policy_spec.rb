describe CoursePolicy do
  subject { CoursePolicy }

  let(:visitor) { nil }
  let(:user) { FactoryGirl.build_stubbed :user }
  # let(:course) { FactoryGirl.build_stubbed :course }
  let(:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :index? do
    it "allows access for everyone" do
      expect(subject).to permit(visitor)
    end
  end

  permissions :show? do
    it "allows access for everyone" do
      expect(subject).to permit(visitor)
    end
  end

  permissions :new? do
    it "allows access for admin" do
      expect(subject).to permit(admin)
    end
    it "does not allow access for everyone else" do
      expect(subject).not_to permit(user, visitor)
    end
  end

  permissions :create? do
    it "allows access for admin" do
      expect(subject).to permit(admin)
    end
    it "does not allow access for everyone else" do
      expect(subject).not_to permit(user, visitor)
    end
  end

  permissions :edit? do
    it "allows access for admin" do
      expect(subject).to permit(admin)
    end
    it "does not allow access for everyone else" do
      expect(subject).not_to permit(user, visitor)
    end
  end

  permissions :update? do
    it "allows access for admin" do
      expect(subject).to permit(admin)
    end
    it "does not allow access for everyone else" do
      expect(subject).not_to permit(user, visitor)
    end
  end

  permissions :destroy? do
    it "allows access for admin" do
      expect(subject).to permit(admin)
    end
    it "does not allow access for everyone else" do
      expect(subject).not_to permit(user, visitor)
    end
  end

end