feature "Creating a Plan" do
  let(:plan_attributes) { attributes_for(:plan) }
  let(:user)            { create :user }

  scenario "as a normal user" do
    signin_user(user)
    visit user_plans_path(user)
    expect(page).to have_title(full_title("Plans"))
    expect(page).to have_link("New Plan")
    click_on "New Plan"
    expect(page).to have_title(full_title("New Plan"))
    fill_in "Name", with: plan_attributes[:name]
    expect { click_on "Create" }.to change(Plan, :count).by(1)
    expect(user.plans.first.name).to eq(plan_attributes[:name])
    expect(page).to have_title(full_title("Plans"))
  end

  scenario "when others already exist" do
    create :plan, user: user
    signin_user user
    visit user_plans_path(user)
    expect(page).to have_title(full_title("Plans"))
    expect(page).to have_link("New Plan")
    click_on "New Plan"
    expect(page).to have_title(full_title("New Plan"))
    fill_in "Name", with: plan_attributes[:name]
    click_on "Create"
    expect(page).to have_title(full_title("Plans"))
  end
end
