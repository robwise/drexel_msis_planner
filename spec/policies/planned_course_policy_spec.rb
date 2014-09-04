describe PlannedCoursePolicy do
  subject { PlannedCoursePolicy }

  let (:visitor)        { nil }
  let (:current_user)   { FactoryGirl.build :user }
  let (:other_user)     { FactoryGirl.build :user }
  let (:admin)          { FactoryGirl.build :user, :admin }
  let (:current_users_plan) { FactoryGirl.build :plan, user: current_user }
  let (:other_users_plan) { FactoryGirl.build :plan, user: other_user }
  let (:current_users_planned_course) { FactoryGirl.build :planned_course,
                                                   plan: current_users_plan }
  let (:other_users_planned_course) { FactoryGirl.build :planned_course,
                                                     plan: other_users_plan }

  permissions ".scope" do
    before do
      current_user.save
      other_user.save
      other_users_plan.save
      current_users_plan.save
      current_users_planned_course.save
      other_users_planned_course.save
    end

    specify "returns planned courses that belong to current user" do
      expect(PlannedCoursePolicy::Scope.new(current_user, PlannedCourse.all).resolve)
        .to include(current_users_planned_course)
    end
    specify "does not return planned courses that do not belong to current user" do
      expect(PlannedCoursePolicy::Scope.new(current_user, PlannedCourse.all).resolve)
        .not_to include(other_users_planned_course)
    end
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
