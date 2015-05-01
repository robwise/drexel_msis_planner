# Calls the Drexel-TMS-Scraper external API to get latest course data and
# then update this app's corresponding data
class TMSScraperService
  require "httparty"

  SCRAPER_URL = "https://nameless-tor-6040.herokuapp.com/course/"

  def update_all_courses_with_scraped_data
    update_courses_with_scraped_data(Course.pluck(:level))
  end

  def update_courses_with_scraped_data(course_levels)
    course_levels.each do |course_level|
      update_course_with_scraped_data(course_level)
    end
  end

  def update_course_with_scraped_data(course_level)
    response = request_course_data_from_external_api(course_level)
    parsed_data = parse_response(response)
    return false if parsed_data.nil?
    course = Course.find_by(level: course_level)
    course.update!(parsed_data[:course_data])
    prerequisite_text = parsed_data[:prerequisite]
    if !prerequisite_text.nil?
      course.update!(prerequisite: prerequisite_text)
    end
    # course.prerequisite.update!(raw_text: parsed_data[:prerequisite])
    # course.corequisite.update!(raw_text: parsed_data[:corequisite])
  end

  private

  def request_course_data_from_external_api(course_level)
    HTTParty.get(SCRAPER_URL + course_level.to_s)
  end

  def parse_response(response)
    return nil unless response.response.code == "200"

    parsed_data = response.parsed_response
    {
      course_data: {
        description: parsed_data["courseDescription"],
        title: parsed_data["title"]
      },
      corequisite: parsed_data["corequisite"],
      prerequisite: parsed_data["prerequisite"]
    }
  end
end
