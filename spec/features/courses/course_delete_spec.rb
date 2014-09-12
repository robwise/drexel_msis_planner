feature "Delete Plan", :js, :slow do
  let!(:course) { create(:course) }
  let(:user)  { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:other_user) { create(:user) }

  scenario "not possible as a user" do
    js_signin_user user
    visit courses_path
    expect(page).not_to have_link('delete')
  end
  scenario "as an admin" do
    js_signin_user admin
    visit courses_path
    successful_deletion
  end

  def successful_deletion
    expect do
      accept_confirm do
        click_on 'delete'
      end
    end.to change(Course, :count).from(1).to(0)
    expect(page).to have_content('Course successfully deleted.')
    expect(page).to have_title(full_title('Courses'))
  end

end