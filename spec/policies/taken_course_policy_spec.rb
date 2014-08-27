describe EnrolledInPolicy do
  subject { EnrolledInPolicy }

  let (:current_user){ FactoryGirl.build_stubbed :user }
  let (:other_user)  { FactoryGirl.build_stubbed :user }
  let (:admin)       { FactoryGirl.build_stubbed :user, :admin }
  let (:enrolled_in) { FactoryGirl.build_stubbed :enrolled_in,
                                                 user_id: current_user.id }

  permissions :new? do
    it "allows access to signed in users" do
      expect(subject).to permit(current_user, enrolled_in)
    end
  end

  permissions :create? do
    it "prevents creation if belonging to other user and not admin" do
      expect(subject).not_to permit(other_user, enrolled_in)
    end
    it "allows creation if belonging to current user" do
      expect(subject).to permit(current_user, enrolled_in)
    end
    it "allows creation for other user if admin" do
      expect(subject).to permit(admin, enrolled_in)
    end
  end

  permissions :edit? do
    it "allows access if belonging to current user" do
      expect(subject).to permit(current_user, enrolled_in)
    end
    it "allows access to admin" do
      expect(subject).to permit(admin, enrolled_in)
    end
    it "denies access if not belonging to current user" do
      expect(subject).not_to permit(other_user, enrolled_in)
    end
  end

  permissions :update? do
    it "prevents updates if not belonging to current user" do
      expect(subject).not_to permit(other_user, enrolled_in)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin, enrolled_in)
    end
    it "allows updates by owner" do
      expect(subject).to permit(current_user, enrolled_in)
    end
  end

  permissions :destroy? do
    it "prevents deletion if not belonging to current user" do
      expect(subject).not_to permit(other_user, enrolled_in)
    end
    it "allows an admin to delete any" do
      expect(subject).to permit(admin, enrolled_in)
    end
    it "allows deletion if belonging to current user" do
      expect(subject).to permit(current_user, enrolled_in)
    end
  end

end
