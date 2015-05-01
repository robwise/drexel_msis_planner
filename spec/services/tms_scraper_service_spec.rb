describe TMSScraperService, type: :service do
  let(:course) { create :course, prerequisite: "BLAH 999 Minimum Grade: C" }
  let(:other_course) { create :course }

  describe "making a request to the web scraper API",
           slow: :true,
           external_api: true do
    it "returns a 200 status code" do
      # 530 is always offered every quarter at Drexel, so this should always
      # return a 200 code if the external scraper API is working properly
      url = described_class::SCRAPER_URL + "530"
      response = HTTParty.get(url)
      expect(response.code).to eq(200)
    end
  end
  context "with stubbed api calls" do
    before do
      stub_tms_scraper_api_calls(course)
      stub_tms_scraper_api_calls(other_course)
    end
    describe "#update_course_with_scraped_data" do
      it "changes the course's description to the new value" do
        expect { subject.update_course_with_scraped_data(course.level) }
          .to change { course.reload.description }
      end
      it "changes the course's prerequisite to the new value" do
        expect do
          subject.update_course_with_scraped_data(course.level)
        end.to change { course.reload.prerequisite }
      end
    end
    describe "#update_all_courses_with_scraped_data" do
      it "changes the course's descriptions" do
        old_description = course.description
        other_old_description = other_course.description
        subject.update_all_courses_with_scraped_data
        expect(course.reload.description).not_to eq old_description
        expect(other_course.reload.description).not_to eq other_old_description
      end
    end
  end
end
