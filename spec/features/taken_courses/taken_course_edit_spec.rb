feature "Editing a taken course", :js, :slow do
  let!(:user) { create(:user) }
  let!(:course) { create(:course) }
  let!(:taken_course) { create(:taken_course,
                               course_id: course.id,
                               user_id: user.id,
                               quarter: '201515')
                              }

  scenario "changing when a course was taken" do
    signin_user user
    visit user_path(user)
    expect(page).to have_content(taken_course.course.title)
    click_on 'edit'
    fill_in :quarter, with: '201525'
    click_on 'save'
    expect(find('quarter').text).to eq('201525')
  end
end