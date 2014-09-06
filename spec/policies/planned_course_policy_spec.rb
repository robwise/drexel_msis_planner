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
end
