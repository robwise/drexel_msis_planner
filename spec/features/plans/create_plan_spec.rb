feature "Creating a Plan" do
  scenario "as a normal user" do
    user = create(:user)
    signin_user(user)
    visit user_plans_path(user)
    expect(page).to have_title(full_title('Plans'))
    expect(page).to have_link('New Plan')
    click_on 'New Plan'
    expect(page).to have_title(full_title('New Plan'))
  end

  xscenario "as an admin" do
    admin = create(:user, :admin)
    signin_user admin
    visit user_plans_path(admin)
    expect(page).to have_title(full_title('Plans'))
    expect(page).to have_link('New Plan')
    click_on 'New Plan'
    expect(page).to have_title(full_title('New Plan'))
  end
end