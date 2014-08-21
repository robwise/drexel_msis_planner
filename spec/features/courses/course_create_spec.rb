feature 'Adding a course' do
  feature "admin" do
    let(:admin) { FactoryGirl.create(:user, :admin) }
    before do
      signin_user admin
      visit new_course_path
    end

    scenario "sees the proper title" do
      expect(page).to have_title("Add a Course")
    end
    scenario "sees the proper heading" do
      expect(page).to have_content('Add a Course')
    end
  end
  xscenario "user tries to add a course" do

  end
end