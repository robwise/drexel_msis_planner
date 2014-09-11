# Feature: User delete
#   As a user
#   I want to delete my user profile
#   So I can close my account
feature 'User delete', :js do

  # Scenario: User can delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  scenario 'user can delete own account', speed: 'slow' do
    user =  create(:user)
    js_signin_user user
    visit edit_user_registration_path(user)
    confirm_message = accept_confirm do
      click_button 'Cancel my account'
    end
    expect(confirm_message).to eq('Are you sure?')
    expect(page).to have_content 'Bye! Your account has been successfully
      cancelled. We hope to see you again soon.'
  end

end




