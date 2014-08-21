feature 'Visiting a course show page' do
  let(:course) { FactoryGirl.create(:course) }
  before { visit course_path(course) }

  scenario "user sees the proper title" do
    expect(page).to have_title(full_title(course.full_id))
  end
  scenario "user sees the course details" do
    expect(page).to have_content(course.description)
    expect(page).to have_content(course.title)
    expect(page).to have_content(course.degree_requirement.humanize.titleize)
  end
end