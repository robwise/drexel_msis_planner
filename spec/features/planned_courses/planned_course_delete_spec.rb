feature "Deleting a planned course" do
  let!(:user) { create :user }
  let!(:plan) { create :plan, user: user }
  let!(:planned_course) { create :planned_course, plan: plan }
  before { signin_user user }

  scenario "signed in user deletes planned course from planner page" do
    visit planner_path
    expect(page).to have_button("unplan")
    expect { click_button "unplan" }.to change(PlannedCourse, :count).by(-1)
    expect(page).not_to have_content(planned_course.full_id)
  end

  scenario "signed in user deletes planned course from courses page" do
    visit courses_path
    expect(page).to have_button("unplan")
    expect { click_button "unplan" }.to change(PlannedCourse, :count).by(-1)
    expect(page).not_to have_button("unplan")
  end
end
