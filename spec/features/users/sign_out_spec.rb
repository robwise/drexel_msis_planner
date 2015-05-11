feature "Sign out", :devise do
  scenario "user signs out successfully" do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    expect(page).to have_content "Signed in successfully."
    expect(page).to have_link "sign out"
    click_on "sign out"
    expect(page).to have_content "Signed out successfully."
  end
end
