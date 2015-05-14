feature "Deleting a planned course", js: true, slow: true do
  let!(:user) { create :user }
  let!(:plan) { create :plan }
  let!(:planned_course) { create :planned_course, plan: plan }
  before { js_signin_user user }

  scenario "signed in user deletes planned course from planner page" do
    visit root_path
    click_button "unplan"
    expect(page).not_to have_content(planned_course.full_id)
    expect(page).to have_deletion_message
  end

  private

  def have_deletion_message
    have_content "#{course.full_id} removed from plan"
  end
end
