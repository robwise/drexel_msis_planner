describe PlannedCoursePolicy do
  subject { described_class }

  let(:visitor)        { nil }
  let(:current_user)   { FactoryGirl.build :user }
  let(:other_user)     { FactoryGirl.build :user }
  let(:admin)          { FactoryGirl.build :user, :admin }
  let(:current_users_plan) { FactoryGirl.build :plan, user: current_user }
  let(:other_users_plan)   { FactoryGirl.build :plan, user: other_user }
  let(:current_users_planned_course) { FactoryGirl.build :planned_course,
                                                   plan: current_users_plan }
  let(:other_users_planned_course)   { FactoryGirl.build :planned_course,
                                                   plan: other_users_plan }

  shared_examples_for "all permission policies" do
    it "raises error if not signed in" do
      expect { described_class.new(visitor, PlannedCourse).create? }
        .to raise_error(Pundit::NotAuthorizedError)
    end
    it "allows access to signed in users" do
      expect(subject).to permit(current_user, current_users_planned_course)
    end
    it "denies access to other users if not admin" do
      expect(subject).not_to permit(current_user, other_users_planned_course)
    end
  end

  permissions :new? do
    it_should_behave_like "all permission policies"
  end

  permissions :create? do
    it_should_behave_like "all permission policies"
  end

  permissions :update? do
    it_should_behave_like "all permission policies"
  end

  permissions :destroy? do
    it_should_behave_like "all permission policies"
  end
end
