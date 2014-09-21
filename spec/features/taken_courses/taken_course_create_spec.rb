feature "Adding a course to user's course history", :js, speed: "slow" do
  let!(:course) { create(:course) }
  let!(:user)   { create(:user) }

  before do
    @current_user = user
    open_taken_course_modal
  end

  scenario "with valid inputs" do
    fill_taken_course_modal(201315, "A+")
    expect(page).to have_success_message
    course_appears_under_users_taken_courses
  end
  scenario "when entering an invalid quarter code" do
    fill_taken_course_modal(quarter: -9999)
    expect(page).to have_quarter_error_message
  end
  scenario "without selecting a grade" do
    fill_taken_course_modal(201315, "NONE")
    expect(page).to have_grade_error_message
  end

  private

    def course_appears_under_users_taken_courses
      visit user_path(@current_user)
      expect(page).to have_content(course.title)
    end

    def have_grade_error_message
      have_content("Error: Grade can't be blank")
    end

    def have_quarter_error_message
      have_content("Error: Quarter is not a valid quarter code")
    end

    def have_success_message
      have_content("Added course to your course history.")
    end

    def open_taken_course_modal
      js_signin_user @current_user
      visit courses_path
      expect(page).to have_link("took this")
      click_on "took this"
    end

end