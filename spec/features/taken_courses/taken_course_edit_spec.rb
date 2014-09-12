feature "Editing an existing taken course" do
  let!(:course)       { create(:course) }
  let!(:user)         { create(:user) }
  let!(:taken_course) do
    create :taken_course, course: course, user: user, quarter: '201415'
  end

  scenario "the 'took this' link does not appear" do
    signin_user user
    visit courses_path
    expect(page).not_to have_content('took this')
  end
  scenario "the edit link appears on the user dashboard" do
    signin_user user
    visit root_path
    expect(page).to have_link('edit')
  end
  xscenario "happy day scenario", :js, speed: 'slow' do
    js_signin_user user
    click_on 'edit'
    fill_in 'Quarter', with: 201425
    click_on 'Save'
    expect(page).to have_text('Quarter: 201425')
  end

end