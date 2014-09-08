feature "Set a Plan as Active" do
  let (:user)  { create :user }
  let!(:plan1) { create :plan, user: user }
  let!(:plan2) { create :plan, user: user }

  # FIX: replace database calls with viewing changes on the page
  scenario "as a normal user" do
    signin_user(user)
    visit user_plans_path(user)
    expect(page).to have_content(plan1.name)
    expect(page).to have_content(plan2.name)
    expect(is_active?(plan1)).to eq false
    expect(is_active?(plan2)).to eq true
    click_on 'set active'
    expect(is_active?(plan2)).to eq false
    expect(is_active?(plan1)).to eq true
  end

  private

    def is_active?(plan)
      active_status_for(plan) == '(Active Plan)'
    end

    def active_status_for(plan)
      page.within("##{plan.name}") do
        find('.active-status').text
      end
    end

end