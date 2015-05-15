feature "Adding a course to a plan" do
  context "as a user" do
    let!(:course) { create(:course) }
    let!(:user) { create(:user) }
    let!(:plan) { create(:plan, user: user) }

    context "with valid course to add", :js, speed: "slow" do
      before do
        js_signin_user user
        visit courses_path
      end

      scenario "can add the course to a plan successfully" do
        click_on("add to plan")
        expect(page).to have_css("#planned-course-modal")
        expect(find(:css, ".modal-title").text)
          .to eq("Add #{course.full_id} to #{plan.name}")
        expect(PlannedCourse.count).to eq(0)
        fill_planned_course_modal(201615)
        expect(page).to have_content("#{course.full_id} added to #{plan.name}")
        expect(PlannedCourse.count).to eq(1)
        expect(page).not_to have_button("add to plan")
        expect(page).to have_button("planned")
      end

      scenario "gets an error when using bad input" do
        click_on("add to plan")
        expect { fill_planned_course_modal("") }.not_to change(PlannedCourse, :count).from(0)
        expect(page).to have_content("Quarter can't be blank")
      end
    end

    context "without a valid course to add" do
      before { signin_user user }

      scenario "the page does not have add buttons for already taken courses" do
        create :taken_course, course: course, user: user
        visit courses_path
        expect(page).not_to have_button("add to plan")
        expect(page).to have_button("add to plan", disabled: true)
      end

      scenario "the page does not have add buttons for already planned courses" do
        create(:planned_course, course: course, plan: plan)
        visit courses_path
        expect(page).not_to have_button("add to plan")
        expect(page).to have_button("planned")
      end
    end
  end

  context "as a visitor" do
    before { visit courses_path }
    scenario "the page does not have button for adding to plan" do
      expect(page).not_to have_button("add to plan")
    end
  end
end
