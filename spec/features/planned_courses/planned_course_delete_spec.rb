feature "Deleting a planned course" do
  let!(:user) { create :user }
  let!(:plan) { create :plan, user: user }
  let!(:planned_course) { create :planned_course, plan: plan }
  before { signin_user user }

  scenario "signed in user deletes planned course from planner page" do
    visit planner_path
    expect(page).to have_button("unplan")
    click_button "unplan"
    expect(page).not_to have_content(planned_course.full_id)
  end
end
