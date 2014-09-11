# Feature: User edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
feature 'User edit', :js do

  # Scenario: User changes email address
  #   Given I am signed in
  #   When I change my email address
  #   Then I see an account updated message
  scenario 'user changes email address' do
    user = FactoryGirl.create(:user)
    js_signin_user (user)
    visit edit_user_registration_path(user)
    fill_in 'Email', with: 'newemail@example.com'
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(page).to have_content 'You updated your account successfully,'
  end

  # Scenario: User cannot edit another user's profile
  #   Given I am signed in
  #   When I try to edit another user's profile
  #   Then I see my own 'edit profile' page
  scenario "user cannot cannot edit another user's profile" do
    user = create(:user)
    other_user = create(:user, email: 'other@example.com')
    js_signin_user user
    visit edit_user_registration_path(other_user)
    expect(page).to have_content 'Edit User'
    expect(page).to have_field('Email', with: user.email)
  end

end
