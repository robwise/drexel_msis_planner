feature 'Adding a course to a plan' do
  let(:course) { create(:course) }
  let(:user) { create(:user) }
  let(:plan) { create(:plan, user: user) }
  before do
    signin_user user
    visit course_path(course)
  end
  xscenario "happy day" do
  end
end
