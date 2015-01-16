feature "Editing an existing taken course" do
  let!(:course)       { create(:course) }
  let!(:user)         { create(:user) }
  let!(:taken_course) do
    create :taken_course, course: course, user: user, quarter: "201415"
  end

  scenario "the 'took this' link does not appear for existing course" do
    signin_user user
    visit courses_path
    expect(page).not_to have_content("took this")
  end
  scenario "the edit for the course link appears on the user dashboard" do
    signin_user user
    visit root_path
    expect(page).to have_link("edit")
  end
  scenario "the modal appears", :js, speed: "slow" do
    js_signin_user user
    visit root_path
    click_on "edit"
    expect(page).to have_text("Edit when you took #{course.full_id}:
      #{course.title.titleize}")
  end
  scenario "updates successfully", :js, speed: "slow" do
    js_signin_user user
    click_on "edit"
    fill_in "Quarter", with: 201425
    click_on "Update"
    expect(page).to have_text("Course history updated")
  end
  scenario "closing a modal and reopening another", :js, speed: "slow" do
    taken_course2 = create :taken_course, user: user
    js_signin_user user
    expect(page).to have_text taken_course2.course.full_id
    within("##{taken_course2.course.short_id}") { click_on "edit" }
    click_on "Close"
    within("##{course.short_id}") { click_on "edit" }
    expect(page).to have_text("Edit when you took #{course.full_id}:
      #{course.title.titleize}")
  end
end
