feature "Enrolling In a Course" do
  let(:course) { create(:course) }
  let(:user)   { create(:user) }

  scenario "user enrolls in a course" do
    signin_user user
    visit course_path(course)
    expect(page).to have_link('I Took This')
    click_link 'I Took This'
    expect(page).to have_title(full_title('Add Enrollment'))
    fill_in 'Quarter', with: 201415
    select 'A+', from: 'Grade'
    expect { click_button 'Add' }.to change(EnrolledIn, :count).by(1)
    expect(page).to have_title(full_title(course.full_id))
    expect(user.enrolled_ins.count).to be > 0
    expect(EnrolledIn.find_by(user_id: user.id)).not_to be_nil
    expect(user.enrolled_ins.first.course_id).to eq(course.id)
    expect(course.enrolled_ins.first.user_id).to eq(user.id)
    expect(page).not_to have_link('I Took This')
    visit users_path
    expect(page).not_to have_link('I Took This')
    visit user_path(user)
    expect(page).to have_content(course.full_id)
  end

end