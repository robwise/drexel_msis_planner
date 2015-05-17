feature "View Navigation links", :devise do
  feature "as a visitor" do
    before { visit root_path }
    scenario "sees proper links" do
      page_has_the_ubiquitous_links
      page_has_the_signed_out_links
      expect(page).not_to have_link "Planner"
      expect(page).not_to have_link "Degree Status"
      expect(page).not_to have_link "sign out"
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
      page_has_the_signed_in_links(user)
      expect(page).not_to have_link "sign in"
      expect(page).not_to have_link "sign up"
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
      page_has_the_signed_in_links(admin)
      page_has_the_admin_only_links
      expect(page).not_to have_link "sign in"
      expect(page).not_to have_link "sign up"
    end
  end

  def page_has_the_signed_out_links
    expect(page).to have_link "sign in"
    expect(page).to have_link "sign up"
  end

  def page_has_the_ubiquitous_links
    expect(page).to have_content "Drexel MSIS Planner"
    expect(page).to have_link "Courses"
  end

  def page_has_the_signed_in_links(signed_in_user)
    expect(page).to have_link "Planner"
    expect(page).to have_link "Degree Status"
    expect(page).to have_link "sign out"
    expect(page).to have_link "#{ signed_in_user.name }"
  end

  def page_has_the_admin_only_links
    expect(page).to have_link "Users"
  end
end
