feature "Home page" do
  context "as a visitor" do
    scenario "visitor sees welcome message" do
      visit root_path
      expect(page).to have_content "Welcome"
    end
  end

  context "as a user" do
    let(:user) { create :user }
    before { signin_user user }
    scenario "user sees dashboard" do
      visit root_path
      expect(page).to have_content "#{ user.name }'s Degree Status"
    end
  end
end
