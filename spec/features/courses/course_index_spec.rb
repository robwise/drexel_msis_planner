feature 'Visiting course index page' do
  before { visit courses_path }
  subject { page }
  scenario "has proper title" do
    expect(page).to have_title(full_title('Courses'))
  end
end