feature "Adding a course to a plan" do
  let!(:course) { create(:course) }
  let!(:user) { create(:user) }
  let!(:plan) { create(:plan, user: user) }

  feature "as a user", :js, speed: "slow" do
    before do
      js_signin_user user
      visit courses_path
    end

    scenario "for a valid course" do
      click_on("add to plan")
      expect(page).to have_css("#planned-course-modal")
      expect(find(:css, ".modal-title").text).to eq("Add #{course.full_id} to #{plan.name}")
      expect(PlannedCourse.count).to eq(0)
      fill_planned_course_modal(201615)
      expect(page).to have_content("#{course.full_id} added to #{plan.name}")
      expect(PlannedCourse.count).to eq(1)
      expect(page).not_to have_button("add to plan")
    end
  end
end
