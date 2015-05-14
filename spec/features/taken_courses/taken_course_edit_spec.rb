feature "Editing an existing taken course" do
  let!(:course)       { create(:course) }
  let!(:user)         { create(:user) }
  let!(:taken_course) do
    create :taken_course, course: course, user: user, quarter: "201415"
  end

  scenario "editing the quarter", :js, speed: "slow" do
    js_signin_user user
    visit root_path
    expect(page).to have_link("edit")
    click_on "edit"
    expect(page).to have_text("Edit when you took #{course.full_id}:
      #{course.title.titleize}")
    fill_in "Quarter", with: 201425
    click_on "Update"
    expect(page).to have_text("Course history updated")
  end
end
