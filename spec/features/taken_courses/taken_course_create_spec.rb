feature "Adding courses taken", :js, speed: 'slow' do
  let!(:course) { create(:course) }
  let!(:user)   { create(:user) }
  let!(:admin)  { create(:user, :admin) }

  scenario "as a user" do
    adding_a_course_as(user)
  end
  scenario "as an admin" do
    adding_a_course_as(admin)
  end
  xscenario "with bad input" do

  end

  def adding_a_course_as(given_user)
    js_signin_user given_user
    visit courses_path
    expect(page).to have_link('took this')
    click_on 'took this'
    fill_in 'Quarter', with: '201415'
    select 'A+', from: 'Grade'
    expect { click_button 'Add' }.to change(TakenCourse, :count).from(0).to(1)
    expect(page).to have_content('Added course to your course history.')
    visit user_path(given_user)
    expect(page).to have_content(course.title)
  end

end