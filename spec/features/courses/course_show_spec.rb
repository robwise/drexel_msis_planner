feature "Visiting a course show page" do
  let(:course) { create(:course) }
  let(:admin)  { create(:user, :admin) }
  before do
    signin_user admin
    visit course_path(course)
  end

  scenario "page has proper title" do
    expect(page).to have_title(full_title(course.full_id))
  end
  scenario "page has course details" do
    expect(page).to have_content(course.description)
    expect(page).to have_content(course.title)
    expect(page).to have_content(course.degree_requirement.humanize.titleize)
  end
end
