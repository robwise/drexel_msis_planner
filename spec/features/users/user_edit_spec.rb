feature "User edit", :js do
  let(:user) { create :user }
  before { js_signin_user user }

  scenario "user changes email address" do
    visit edit_user_registration_path(user)
    fill_in "Email", with: "newemail@example.com"
    fill_in "Current password", with: user.password
    click_button "Update"
    expect(page).to have_content "You updated your account successfully,"
  end

  scenario "user cannot cannot edit another user's profile" do
    other_user = create(:user, email: "other@example.com")
    visit edit_user_registration_path(other_user)
    expect(page).to have_content "Edit User"
    expect(page).to have_field("Email", with: user.email)
  end

  scenario "user changes name" do
    old_name = user.name
    visit edit_user_registration_path(user)
    fill_in "Name", with: "new name"
    fill_in "Current password", with: user.password
    click_button "Update"
    expect(page).to have_content "Your account has been updated successfully"
    expect(old_name).not_to eq(user.reload.name)
  end

  scenario "user receives an error when updating wrong password" do
    old_name = user.name
    visit edit_user_registration_path(user)
    fill_in "Name", with: "new name"
    fill_in "Current password", with: "silly password"
    click_button "Update"
    expect(page).not_to have_content "Your account has been updated successfully"
    expect(old_name).to eq(user.reload.name)
  end
end
