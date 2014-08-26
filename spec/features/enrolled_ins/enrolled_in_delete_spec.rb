feature "Deleting an enrollment" do
  let!(:user) { create(:user) }
  let!(:course) { create(:course) }
  let!(:enrollment) { create(:enrolled_in, course_id: course.id, user_id: user.id) }
  subject { enrollment }

  scenario "deleting an existing enrollment" do
    signin_user user
    visit user_path(user)
    expect(page).to have_content(user.email)
    # expect(page).to have_button('remove')
    expect { click_on('remove') }.to change(EnrolledIn, :count).by(-1)
  end
end