feature "Editing an existing taken course" do
  let!(:course)       { create(:course) }
  let!(:user)         { create(:user) }
  let!(:taken_course) do
    create :taken_course, course: course, user: user, quarter: "201415"
  end

  scenario "the 'taken' link does not appear for existing course" do
    signin_user user
    visit courses_path

    expect(page).to have_css(".new-taken-course-button-disabled")
    expect(page).not_to have_css(".new-taken-course-button")
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
    visit root_path

    click_on "edit"
    fill_in "Quarter", with: 201425
    click_on "Update"
    expect(page).to have_text("Course history updated")
  end
end
