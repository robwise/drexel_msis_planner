feature 'Visiting course index page' do
  before { visit courses_path }

  scenario "user sees the proper title" do
    expect(page).to have_title(full_title('Courses'))
  end
end