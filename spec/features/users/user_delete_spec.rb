feature "User delete", :js, speed: "slow" do
  scenario "user can delete own account" do
    user = create(:user)
    js_signin_user user
    visit edit_user_registration_path(user)
    confirm_message = accept_confirm do
      click_button "Cancel my account"
    end
    expect(confirm_message).to eq("Are you sure?")
    expect(page).to have_content "Bye! Your account has been successfully
      cancelled. We hope to see you again soon."
  end
end
