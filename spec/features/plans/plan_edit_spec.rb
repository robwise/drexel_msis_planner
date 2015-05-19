feature "Editing a Plan" do
  let(:user) { create :user }
  let!(:plan1) { create :plan, user: user }
  let(:plan2) { build :plan, user: user }

  scenario "set a plan as active as a user", :js, :slow do
    plan2.save
    js_signin_user(user)
    visit user_plans_path(user)
    expect(page).to have_content(plan1.name)
    expect(page).to have_content(plan2.name)
    expect(active?(plan1)).to eq false
    expect(activate_button_for?(plan1)).to eq true
    expect(active?(plan2)).to eq true
    expect(activate_button_for?(plan2)).to eq false
    click_button "set active"
    expect(page).to have_successful_update_message
    expect(active?(plan1)).to eq true
    expect(activate_button_for?(plan1)).to eq false
    expect(active?(plan2)).to eq false
    expect(activate_button_for?(plan2)).to eq true
  end

  scenario "change the name of a plan as a user" do
    signin_user user
    visit user_plans_path(user)
    expect(page).to have_title(full_title("Plans"))
    expect(page).to have_content(plan1.name)
    expect(page).to have_link("edit")
    click_link "edit"
    expect(page).to have_title(full_title("Edit Plan"))
    fill_in "plan_name", with: "my awesome plan title"
    click_button "Update"
    expect(page).to have_title(full_title("Plans"))
    expect(page).to have_content("my awesome plan title")
    expect(page).to have_successful_update_message
  end

  scenario "change the name of a plan as a user using an invalid name" do
    plan2.save
    signin_user user
    visit user_plans_path(user)
    expect(page).to have_title(full_title("Plans"))
    expect(page).to have_content(plan1.name)
    expect(page).to have_content(plan2.name)
    plan1_row = page.find("##{plan1.name}")
    expect(plan1_row).to have_link("edit")
    within plan1_row do
      click_link "edit"
    end
    expect(page).to have_title(full_title("Edit Plan"))
    fill_in "plan_name", with: plan2.name
    click_button "Update"
    expect(page).to have_title(full_title("Plans"))
    expect(page).to have_failure_update_message
  end

  private

  def active?(plan)
    active_status_for(plan) == "(Active Plan)"
  end

  def active_status_for(plan)
    page.within("##{plan.name}") do
      find(".active-status").text
    end
  end

  def activate_button_for?(plan)
    page.within("##{plan.name}") do
      !has_no_button?("set active")
    end
  end

  def have_successful_update_message
    have_content("Plan was successfully updated.")
  end

  def have_failure_update_message
    have_content("Error updating plan.")
  end
end
