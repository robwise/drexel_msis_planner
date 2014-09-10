feature "Delete Plan", :js do
  let!(:plan) { create(:plan, user: user) }
  let(:user)  { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:other_user) { create(:user) }

  scenario "as a user" do
    js_signin_user(user)
    visit user_plans_path(user)
    successful_deletion
  end
  scenario "as an admin" do
    js_signin_user(admin)
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