# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'User profile page', :js, speed: 'slow' do

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'user sees own profile' do
    user = create(:user)
    js_signin_user user
    visit user_path(user)
    expect(page).to have_content user.email
  end

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I see an 'access denied' message
  scenario "user cannot see another user's profile" do
    user = create(:user)
    other_user = create(:user, email: 'other_user@example.com')
    js_signin_user(user)
    visit user_path(other_user)
    expect(page).to have_content 'Access denied.'
  end

end
