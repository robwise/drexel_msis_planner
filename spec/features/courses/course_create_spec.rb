feature "When adding a course" do
  feature "admin" do
    let(:admin) { FactoryGirl.create(:user, :admin) }
    let(:course) { FactoryGirl.build(:course) }
    before do
      signin_user admin
      visit new_course_path
    end

    scenario "sees the proper title" do
      expect(page).to have_title("Add a Course")
    end
    scenario "sees the proper heading" do
      expect(page).to have_content("Add a Course")
    end
    scenario "submits valid form" do
      expect { fill_course_form(course) }.to change(Course, :count).by(1)
      course_in_database = Course.find_by(department: course.department,
                                          level: course.level)
      expect(current_path).to eq(course_path(course_in_database))
    end
    scenario "submits invalid form" do
      course.department = " "
      expect { fill_course_form(course) }.not_to change(Course, :count)
    end
  end

  feature "non-admin" do
    let(:user) { FactoryGirl.create(:user) }
    let(:course) { FactoryGirl.build(:course) }
    before do
      signin_user user
      visit new_course_path
    end
    scenario "is unable to view the new course page" do
      expect(page).not_to have_title("Add a Course")
      expect(page).not_to have_content("Add a Course")
    end
  end
end
