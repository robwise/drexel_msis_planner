feature "Adding a course to user's course history", :js, speed: "slow" do
  let!(:course) { create(:course) }
  let!(:user)   { create(:user) }

  before do
    user
    js_signin_user user
    visit courses_path
  end

  scenario "is done via courses page" do
    expect(page).to have_button("took this")
  end

  feature "via the modal" do
    before { click_on "took this" }

    scenario "displays properly" do
      expect(page).to have_text("Add #{course.full_id}: #{course.title.titleize}
        to Taken Courses")
    end
    scenario "with valid inputs" do
      fill_taken_course_modal(201315, "A+")
      expect(page).to have_content("Course added to taken courses")
      visit user_path(user)
      expect(page).to have_content(course.title)
    end
    scenario "with an invalid quarter code" do
      fill_taken_course_modal(quarter: -9999)
      expect(page).to have_content("Error: Quarter is not a valid quarter code")
    end
    scenario "without selecting a grade" do
      fill_taken_course_modal(201315, "NONE")
      expect(page).to have_content("Error: Grade can't be blank")
    end
  end
end
