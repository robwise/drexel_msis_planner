module ServicesHelpers
  module TMSScraperHelpers
    def stub_tms_scraper_api_calls(course)
      response_response = double(code: "200")
      response =
        double(parsed_response: { "title" => course.title,
                                  "courseDescription" => "a new description" },
               response: response_response)
      request_url = TMSScraperService::SCRAPER_URL + course.level.to_s
      allow(HTTParty).to receive(:get).with(request_url).and_return(response)
    end
  end
end
