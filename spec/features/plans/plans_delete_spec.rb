include Warden::Test::Helpers
Warden.test_mode!

feature "Delete Plan", :devise, :js do
  let!(:plan) { create(:plan, user: user) }
  let(:user)  { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:other_user) { create(:user) }
  after(:each) do
    Warden.test_reset!
  end

  scenario "as a user" do
    login_as user
    visit user_plans_path(user)
    successful_deletion
  end
  scenario "as an admin" do
    login_as admin
    visit user_plans_path(user)
    successful_deletion
  end

  def successful_deletion
    expect do
      accept_confirm do
        click_on 'delete'
      end
    end.to change(Plan, :count).from(1).to(0)
    expect(user.plans(true).size).to eq(0)
    expect(Plan.count).to eq(0)
    expect(page).to have_content('Plan was successfully deleted.')
    expect(page).to have_title(full_title('Plans'))
  end
end