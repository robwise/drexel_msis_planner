describe PlanPolicy do
  subject { described_class }

  let(:visitor)            { nil }
  let(:current_user)       { FactoryGirl.build :user }
  let(:other_user)         { FactoryGirl.build :user }
  let(:admin)              { FactoryGirl.build :user, :admin }
  let(:other_users_plan)   { FactoryGirl.create :plan, user: other_user }
  let(:current_users_plan) { FactoryGirl.create :plan, user: current_user }

  describe "policy_scope" do
    before do
      current_users_plan.save
      other_users_plan.save
    end
    it "is nil for a visitor" do
      expect(PlanPolicy::Scope.new(visitor, Plan.all).resolve).to be_nil
    end
    it "denies access if not belonging to current user" do
      expect(PlanPolicy::Scope.new(current_user, Plan.all).resolve)
        .not_to include(other_users_plan)
    end
    it "allows access if belonging to current user" do
      expect(PlanPolicy::Scope.new(current_user, Plan.all).resolve)
        .to include(current_users_plan)
    end
    it "allows access to admin" do
      expect(PlanPolicy::Scope.new(admin, Plan.all).resolve)
        .to include(current_users_plan)
    end
  end

  permissions :index? do
    it "raises error if not signed in" do
      expect { subject.new(visitor, Plan).new? }
        .to raise_error(Pundit::NotAuthorizedError)
    end
    it "allows access if signed in" do
      expect(subject).to permit(current_user)
    end
  end

  permissions :new? do
    it "raises error if not signed in" do
      expect { subject.new(visitor, Plan).new? }
        .to raise_error(Pundit::NotAuthorizedError)
    end
    it "allows access to signed in users" do
      expect(subject).to permit(current_user, Plan.new(user: current_user))
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

  permissions :planner? do
    it "raises error if not signed in" do
      expect { subject.new(visitor, Plan).planner? }
        .to raise_error(Pundit::NotAuthorizedError)
    end
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
