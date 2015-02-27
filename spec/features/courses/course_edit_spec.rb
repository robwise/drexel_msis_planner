feature "Editing a course" do
  let!(:course) { create(:course) }
  feature "as an admin" do
    let!(:admin) { create(:user, :admin) }
    before { signin_user admin }

    scenario "using valid attributes" do
      visit courses_path
      expect(page).to have_link("edit")
      click_on "edit"
      expect(page).to have_title(full_title("Edit Course"))
      expect(page).to have_content(course.full_id)
      course.department = "ECON"
      fill_course_form(course)
      course_in_database = Course.find_by(id: course.id)
      expect(course_in_database.department).to eq("ECON")
    end

    scenario "using invalid attributes" do
      visit edit_course_path(course)
      course.level = -99
      fill_course_form(course)
      course_in_database = Course.find_by(id: course.id)
      expect(course_in_database.level).not_to eq(-99)
      expect(page).to have_selector(".alert", "Error updating course.")
    end
  end

  feature "as a non-admin" do
    let!(:user) { create(:user) }
    before { signin_user user }

    scenario "is not possible" do
      visit courses_path
      expect(page).not_to have_link("edit")
    end
  end

  feature "as a visitor" do
    scenario "is not possible" do
      visit courses_path
      expect(page).not_to have_link("edit")
    end
  end
end
