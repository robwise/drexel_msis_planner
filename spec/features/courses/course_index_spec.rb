feature "Visiting course index page" do
  before { visit courses_path }

  scenario "user sees the proper title" do
    expect(page).to have_title(full_title("Courses"))
    expect(page).to have_content("Courses")
  end

  scenario "user sees the courses" do
    course = create :course
    visit courses_path
    expect(page).to have_content(course.title)
  end
end
