include Warden::Test::Helpers
Warden.test_mode!

# Feature: User delete
#   As a user
#   I want to delete my user profile
#   So I can close my account
feature 'User delete', :devise, :js do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User can delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  scenario 'user can delete own account', speed: 'slow' do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
    visit edit_user_registration_path(user)
    accept_confirm do
      click_button 'Cancel my account'
    end
    expect(page).to have_content 'Bye! Your account has been successfully cancelled. We hope to see you again soon.'
  end

end




