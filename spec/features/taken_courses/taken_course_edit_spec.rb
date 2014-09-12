feature "Editing a taken course", :js, speed: 'slow' do
  let!(:user)         { create(:user) }
  let!(:course)       { create(:course) }
  # let!(:taken_course) { create(:taken_course,
  #                              course_id: course.id,
  #                              user_id: user.id,
  #                              quarter: '201515')    }

  xscenario "as a user" do
    js_signin_user user
    visit courses_path
    click_on 'took this'
    fill_in 'Quarter', with: '201315'
    select 'A+', from: 'Grade'
    click_on 'Add'
    visit user_path(user)
    expect(page).to have_content(taken_course.course.title)
    click_on 'edit'
    expect(page).to have_title()
    fill_in :quarter, with: '201525'
    click_on 'save'
    expect(find('quarter').text).to eq('201525')
  end
end