describe PlanPolicy do
  subject { PlanPolicy }

  let (:visitor)            { nil }
  let (:current_user)       { FactoryGirl.build :user }
  let (:other_user)         { FactoryGirl.build :user }
  let (:admin)              { FactoryGirl.build :user, :admin }
  let (:other_users_plan)   { FactoryGirl.build :plan, user: other_user }
  let (:current_users_plan) { FactoryGirl.build :plan, user: current_user }

  permissions :show? do
    it "denies access if not belonging to current user" do
      expect(subject).not_to permit(current_user, other_users_plan)
    end
    it "allows access if belonging to current user" do
      expect(subject).to permit(current_user, current_users_plan)
    end
    it "allows access to admin" do
      expect(subject).to permit(admin, other_users_plan)
    end
  end

  permissions :new? do
    it "raises error if not signed in" do
      expect { PlanPolicy.new(visitor, Plan).new? }
        .to raise_error(Pundit::NotAuthorizedError)
    end
    it "allows access to signed in users" do
      expect(subject).to permit(current_user)
    end
  end

  permissions :edit? do
    it "denies access if not belonging to current user" do
      expect(subject).not_to permit(current_user, other_users_plan)
    end
    it "allows access if belonging to current user" do
      expect(subject).to permit(current_user, current_users_plan)
    end
    it "allows access to admin" do
      expect(subject).to permit(admin, other_users_plan)
    end
  end

  permissions :create? do
    it "denies access if not belonging to current user" do
      expect(subject).not_to permit(current_user, other_users_plan)
    end
    it "allows access if belonging to current user" do
      expect(subject).to permit(current_user, current_users_plan)
    end
    it "allows access to admin" do
      expect(subject).to permit(admin, other_users_plan)
    end
  end

  permissions :update? do
    it "denies access if not belonging to current user" do
      expect(subject).not_to permit(current_user, other_users_plan)
    end
    it "allows access if belonging to current user" do
      expect(subject).to permit(current_user, current_users_plan)
    end
    it "allows access to admin" do
      expect(subject).to permit(admin, other_users_plan)
    end
  end

  permissions :destroy? do
    it "denies access if not belonging to current user" do
      expect(subject).not_to permit(current_user, other_users_plan)
    end
    it "allows access if belonging to current user" do
      expect(subject).to permit(current_user, current_users_plan)
    end
    it "allows access to admin" do
      expect(subject).to permit(admin, other_users_plan)
    end
  end

end
