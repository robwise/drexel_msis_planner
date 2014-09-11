feature "Deleting a taken course" do
  let!(:user) { create(:user) }
  let!(:course) { create(:course) }
  let!(:taken_course) { create(:taken_course, course_id: course.id, user_id: user.id) }

  scenario "deleting an existing taken_course" do
    signin_user user
    visit user_path(user)
    expect(page).to have_content(taken_course.course.title)
    expect(page).to have_link('remove')
    expect { click_on('remove') }.to change(TakenCourse, :count).by(-1)
  end
end