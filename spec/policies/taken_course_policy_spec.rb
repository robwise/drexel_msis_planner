describe TakenCoursePolicy do
  subject { TakenCoursePolicy }

  let (:current_user){ FactoryGirl.build_stubbed :user }
  let (:other_user)  { FactoryGirl.build_stubbed :user }
  let (:admin)       { FactoryGirl.build_stubbed :user, :admin }
  let (:taken_course) { FactoryGirl.build_stubbed :taken_course,
                                                 user_id: current_user.id }

  permissions :new? do
    it "allows access to signed in users" do
      expect(subject).to permit(current_user, taken_course)
    end
  end

  permissions :create? do
    it "prevents creation if belonging to other user and not admin" do
      expect(subject).not_to permit(other_user, taken_course)
    end
    it "allows creation if belonging to current user" do
      expect(subject).to permit(current_user, taken_course)
    end
    it "allows creation for other user if admin" do
      expect(subject).to permit(admin, taken_course)
    end
  end

  permissions :edit? do
    it "allows access if belonging to current user" do
      expect(subject).to permit(current_user, taken_course)
    end
    it "allows access to admin" do
      expect(subject).to permit(admin, taken_course)
    end
    it "denies access if not belonging to current user" do
      expect(subject).not_to permit(other_user, taken_course)
    end
  end

  permissions :update? do
    it "prevents updates if not belonging to current user" do
      expect(subject).not_to permit(other_user, taken_course)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin, taken_course)
    end
    it "allows updates by owner" do
      expect(subject).to permit(current_user, taken_course)
    end
  end

  permissions :destroy? do
    it "prevents deletion if not belonging to current user" do
      expect(subject).not_to permit(other_user, taken_course)
    end
    it "allows an admin to delete any" do
      expect(subject).to permit(admin, taken_course)
    end
    it "allows deletion if belonging to current user" do
      expect(subject).to permit(current_user, taken_course)
    end
  end

end
