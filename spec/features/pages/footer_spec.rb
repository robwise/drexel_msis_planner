feature "Footer" do
  let(:ubiquitous_links) { ["Rob Wise", "Courses"] }
  let(:visitor_links) { ubiquitous_links + ["Drexel MSIS Planner"] }
  let(:signed_in_user_links) { ubiquitous_links + ["Planner", "Degree Status"] }
  let(:admin_links) { signed_in_user_links + ["Users"] }
  let(:footer) { page.find("footer") }

  shared_examples "footer_links" do
    it "shows the appropriate links" do
      links.each do |link|
        expect(footer).to have_link(link)
      end
    end
  end

  context "when viewed by a visitor" do
    before do
      visit root_path
    end
    let(:links) { visitor_links }
    include_examples "footer_links"
  end
  context "when viewed by a user" do
    before do
      user = create :user
      signin_user user
    end
    let(:links) { signed_in_user_links }
    include_examples "footer_links"
  end
  context "when viewed by an admin" do
    before do
      admin = create :user, :admin
      signin_user admin
    end
    let(:links) { admin_links }
    include_examples "footer_links"
  end
end
