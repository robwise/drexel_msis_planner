feature "Adding a course to user's course history" do
  let!(:course) { create(:course) }
  let!(:user)   { create(:user) }

  scenario "when the course has already been taken" do
    create(:taken_course, user: user, course: course)
    signin_user user
    visit courses_path
    expect(page).to have_button("taken")
  end
  scenario "with a valid course to add and using valid inputs", :js, speed: "slow" do
    js_signin_user user
    visit courses_path
    expect(page).to have_button("taken")
    click_on "taken"
    expect(page).to have_text("Add #{course.full_id}: #{course.title.titleize}
      to Taken Courses")
    fill_taken_course_modal(201315, "A+")
    expect(page).to have_content("Course added to taken courses")
    expect(page).to have_button("taken")
    visit root_path
    expect(page).to have_content(course.full_id)
  end
  scenario "with an invalid quarter code", :js, speed: "slow" do
    js_signin_user user
    visit courses_path
    expect(page).to have_button("add to taken")
    click_on "add to taken"
    expect(page).to have_text("Add #{course.full_id}: #{course.title.titleize}
      to Taken Courses")
    fill_taken_course_modal(quarter: -9999)
    expect(page).to have_content("Error: Quarter is not a valid quarter code")
  end
  scenario "without selecting a grade", :js, speed: "slow" do
    js_signin_user user
    visit courses_path
    expect(page).to have_button("add to taken")
    click_on "add to taken"
    expect(page).to have_text("Add #{course.full_id}: #{course.title.titleize}
      to Taken Courses")
    fill_taken_course_modal(201315, "NONE")
    expect(page).to have_content("Error: Grade can't be blank")
  end
end
