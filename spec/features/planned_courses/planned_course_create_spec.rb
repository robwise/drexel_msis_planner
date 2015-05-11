feature "Adding a course to a plan" do
  feature "as a user" do
    let!(:course) { create(:course) }
    let!(:user) { create(:user) }
    let!(:plan) { create(:plan, user: user) }

    feature "with valid course to add", :js, speed: "slow" do
      before do
        js_signin_user user
        visit courses_path
      end

      scenario "valid planned course" do
        click_on("add to plan")
        expect(page).to have_css("#planned-course-modal")
        expect(find(:css, ".modal-title").text)
          .to eq("Add #{course.full_id} to #{plan.name}")
        expect(PlannedCourse.count).to eq(0)
        fill_planned_course_modal(201615)
        expect(page).to have_content("#{course.full_id} added to #{plan.name}")
        expect(PlannedCourse.count).to eq(1)
        expect(page).not_to have_button("add to plan")
      end

      scenario "bad input" do
        click_on("add to plan")
        expect(PlannedCourse.count).to eq(0)
        fill_planned_course_modal("")
        expect(page).to have_content("Quarter can't be blank")
        expect(PlannedCourse.count).to eq(0)
      end
    end

    feature "without valid course to add" do
      before { signin_user user }

      scenario "already taken course" do
        create(:taken_course, course: course, user: user)
        visit courses_path
        expect(page).not_to have_button("add to plan")
      end

      scenario "already planned course" do
        create(:planned_course, course: course, plan: plan)
        visit courses_path
        expect(page).not_to have_button("add to plan")
      end
    end
  end

  scenario "as a visitor" do
    visit courses_path
    expect(page).not_to have_button("add to plan")
  end
end
