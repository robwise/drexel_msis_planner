include Warden::Test::Helpers
Warden.test_mode!

feature 'User index page', :devise do
  let(:user) { FactoryGirl.create(:user, :admin) }
  before do
    login_as(user, scope: :user)
    visit users_path
  end
  after(:each) do
    Warden.test_reset!
  end

  scenario 'user sees own email address' do
    expect(page).to have_content user.email
  end
  scenario 'has proper title' do
    expect(page).to have_title(full_title('Users'))
  end
end
