module ServiceSpecsHelpers
  module TMSScraperHelpers
    def stub_tms_scraper_api_calls(course)
      attrs = attributes_for :course, :with_prerequisite
      response_response = double(code: "200")
      response =
        double(parsed_response: { "title" => course.title,
                                  "courseDescription" =>  attrs[:description],
                                  "prerequisite" => attrs[:prerequisite] },
               response: response_response)
      request_url = TMSScraperService::SCRAPER_URL + course.level.to_s
      allow(HTTParty).to receive(:get).with(request_url).and_return(response)
    end
  end
end
