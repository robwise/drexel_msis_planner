feature "Adding courses taken" do
  let!(:course) { create(:course) }
  let!(:user)   { create(:user) }

  scenario "happy day scenario" do
    signin_user user
    visit courses_path
    expect(page).to have_button('took this')
    click_button 'took this'
    fill_in 'Quarter', with: 201415
    select 'A+', from: 'Grade'
    expect { click_button 'Add' }.to change(TakenCourse, :count).by(1)
    visit user_path(user)
  end

end