describe TMSScraperService, type: :service do
  let(:course) { create :course, :with_prerequisite, :with_corequisite }
  let(:other_course) { create :course }

  shared_examples "the #update_course method" do
    it "changes the course's title to the new value" do
      expect { subject.update_course(argument) }
        .to change { course.reload.title }
    end
    it "changes the course's description to the new value" do
      expect { subject.update_course(argument) }
        .to change { course.reload.description }
    end
    it "changes the course's prerequisite to the new value" do
      expect { subject.update_course(argument) }
        .to change { course.reload.prerequisite }
    end
    it "changes the course's corequisite to the new value" do
      expect { subject.update_course(argument) }
        .to change { course.reload.corequisite }
    end
    context "with a bad response code" do
      let(:additional_stub_options) { :bad_response_code }
      let(:error_message) do
        "TMS Scraper Service: course retrieval from TMS Scraper API failed for"\
          " course level #{ course.level }. Received response 404."
      end
      include_examples "encountering an error"
    end
    context "with no prerequisite in response" do
      let(:additional_stub_options) { :nil_prerequisite_text }
      let(:error_message) do
        "Encountered abnormal data during retrieval from TMS Scraper API."\
          " #{ course.full_id }'s prerequisite was nil."
      end
      include_examples "encountering an error"
    end
    context "with no corequisite in response" do
      let(:additional_stub_options) { :nil_corequisite_text }
      let(:error_message) do
        "Encountered abnormal data during retrieval from TMS Scraper API."\
          " #{ course.full_id }'s corequisite was nil."
      end
      include_examples "encountering an error"
    end
    context "with no title in response" do
      let(:additional_stub_options) { :nil_title_text }
      let(:error_message) { "TMS Scraper Service: encountered" }
      include_examples "encountering an error"
    end
    context "with no description in response" do
      let(:additional_stub_options) { :nil_description_text }
      let(:error_message) { "TMS Scraper Service: encountered" }
      include_examples "encountering an error"
    end
    context "with a blank title in response" do
      let(:additional_stub_options) { :blank_title_text }
      let(:error_message) { "TMS Scraper Service: encountered" }
      include_examples "encountering an error"
    end
    context "with a blank description in response" do
      let(:additional_stub_options) { :blank_description_text }
      let(:error_message) { "TMS Scraper Service: encountered" }
      include_examples "encountering an error"
    end
  end

  shared_examples "encountering an error" do
    it "calls Rails.logger with the appropriate message" do
      expect(Rails.logger).to receive(:error).with(/#{ error_message }/)
      subject.update_course(course)
    end
  end

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
    let(:additional_stub_options) { [] }
    before do
      stub_tms_scraper_api_calls(course, additional_stub_options)
      stub_tms_scraper_api_calls(other_course, additional_stub_options)
    end
    describe "#update_course(course)" do
      let(:argument) { course }
      include_examples "the #update_course method"
    end
    describe "#update_course(course.level)" do
      let(:argument) { course.level }
      include_examples "the #update_course method"
    end
    describe "#update_all_courses" do
      it "changes the course's descriptions" do
        old_description = course.description
        other_old_description = other_course.description
        subject.update_all_courses
        expect(course.reload.description).not_to eq old_description
        expect(other_course.reload.description).not_to eq other_old_description
      end
    end
  end
end
