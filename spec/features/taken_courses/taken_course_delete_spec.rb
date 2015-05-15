feature "Deleting a taken course" do
  let!(:user) { create(:user) }
  let!(:course) { create(:course) }
  let!(:taken_course) do
    create(:taken_course, course_id: course.id, user_id: user.id)
  end

  context "as a user" do
    before { signin_user user }

    xscenario "from the degree status page" do
      visit root_path
      expect(page).to have_content(taken_course.course.full_id)
      expect(page).to have_link("remove")
      expect { click_on("remove") }.to change(TakenCourse, :count).by(-1)
    end

    xscenario "from the planner page" do
      visit planner_path
      expect(page).to have_content(taken_course.full_id)
      expect(page).to have_button("taken")
      expect { click_on("button") }.to change(TakenCourse, :count).by(-1)
      expect(page).not_to have_content(taken_course.full_id)
    end

    scenario "from the courses page" do
      visit courses_path
      expect(page).to have_content(course.full_id)
      expect(page).to have_button("taken")
      expect { click_on("taken") }.to change(TakenCourse, :count).by(-1)
      expect(page).to have_button("add to taken")
    end
  end
end
