feature "Set a Plan as Active" do
  let(:user)  { create :user }
  let!(:plan1) { create :plan, user: user }
  let!(:plan2) { create :plan, user: user }

  scenario "as a normal user", :js, :slow do
    js_signin_user(user)
    visit user_plans_path(user)
    expect(page).to have_content(plan1.name)
    expect(page).to have_content(plan2.name)
    expect(active?(plan1)).to eq false
    expect(activate_button_for?(plan1)).to eq true
    expect(active?(plan2)).to eq true
    expect(activate_button_for?(plan2)).to eq false
    click_button "set active"
    expect(page).to have_content("Plan was successfully updated.")
    expect(active?(plan1)).to eq true
    expect(activate_button_for?(plan1)).to eq false
    expect(active?(plan2)).to eq false
    expect(activate_button_for?(plan2)).to eq true
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
end
