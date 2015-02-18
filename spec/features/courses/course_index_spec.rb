feature "Visiting course index page" do
  scenario "visitor sees courses without logged-in only content" do
    course = create :course
    visit courses_path
    expect(page).to have_title(full_title("Courses"))
    expect(page).to have_content("Courses")
    expect(page).to have_content(course.title)
    expect(page).not_to have_content("taken")
    expect(page).not_to have_content("took this")
  end
end
