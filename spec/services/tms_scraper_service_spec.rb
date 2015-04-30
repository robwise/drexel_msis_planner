describe TMSScraperService do
  subject(:subject) { described_class }
  let(:course) do
    create :course, level: "530", description: "a silly description"
  end
  let(:other_course) do
    create :course, level: "605", description: "other silly description"
  end

  describe "valid calls to web scraper", slow: :true, external_api: true do
    it "return a 200 status code" do
      # 530 is always offered every quarter at Drexel, so this should always
      # return a 200 code if the external scraper API is working properly
      url = subject::SCRAPER_URL + "530"
      response = HTTParty.get(url)
      expect(response.code).to eq(200)
    end
  end

  describe "#update_course_with_scraped_data" do
    it "changes the course description to its new value" do

      response_response = double(code: "200")
      response = double(parsed_response: { "title" => course.title, "courseDescription" => "a new description" }, response: response_response)
      # response.instance_variable_set(:code, "200")
      allow(HTTParty).to receive(:get).and_return(response)
      # allow(HTTParty::Response).to receive()

      # parsed_json = { "courseDescription" => "a new description" }
      # allow(JSON).to receive(:parse).and_return(parsed_json)
      # expect(JSON.parse(nil)[:course_data]["courseDescription"])
        # .to eq "a new description"

      expect { subject.update_course_with_scraped_data(course.level) }
        .to change { course.reload.description }
    end
  end

  describe "#update_all_courses_with_scraped_data" do
    it "updates the course descriptions" do
      old_description = course.description
      other_old_description = other_course.description
      subject.update_all_courses_with_scraped_data
      expect(course.reload.description).not_to eq old_description
      expect(other_course.reload.description).not_to eq other_old_description
    end
  end
end
