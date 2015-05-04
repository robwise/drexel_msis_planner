feature "View Navigation links", :devise do
  feature "as a visitor" do
    before { visit root_path }
    scenario "sees proper links" do
      page_has_the_ubiquitous_links
      page_has_the_signed_out_links
    end
  end

  context "as a user" do
    let(:user) { create :user }
    before do
      signin_user user
      visit root_path
    end
    scenario "sees proper links" do
      page_has_the_ubiquitous_links
      page_has_the_signed_in_links
    end
  end

  context "as an admin" do
    let(:admin) { create :user, :admin }
    before do
      signin_user admin
      visit root_path
    end
    scenario "sees proper links" do
      page_has_the_ubiquitous_links
      page_has_the_signed_in_links
      page_has_the_admin_only_links
    end
  end

  def page_has_the_signed_out_links
    expect(page).to have_content "Sign in"
    expect(page).to have_content "Sign up"
  end

  def page_has_the_ubiquitous_links
    expect(page).to have_content "Home"
    expect(page).to have_content "Courses"
  end

  def page_has_the_signed_in_links
    expect(page).to have_content "Planning"
    expect(page).to have_content "Sign out"
    expect(page).to have_content "Edit account"
  end

  def page_has_the_admin_only_links
    expect(page).to have_content "Users"
  end
end
