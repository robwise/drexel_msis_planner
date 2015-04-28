class TMSScraperService
  require "httparty"
  require "json"

  SCRAPER_URL = "https://nameless-tor-6040.herokuapp.com/course/"

  def update_courses_with_scraped_data(course_levels)
    course_levels.each { |course_level| update_course(course_level) }
  end

  def update_course_with_scraped_data(course_level)
    course_json = request_data_for_course(course_level)
    parsed_data = parse_course_json(course_json)
    course = Course.find_by(level: course_level)
    course.update!(title: parsed_data[:title], description: parsed_data[:description])
    # course.prerequisite.update!(raw_text: parsed_data[:prerequisite])
    # course.corequisite.update!(raw_text: parsed_data[:corequisite])
  end

  private

  def request_data_for_course(course_level)
    HTTParty.get(SCRAPER_URL + course_level.to_s).response
  end

  def parse_course_json(response)
    # return nil unless response.code == 200
    course_json = JSON.parse response.body
    parsed_data = {}
    course_data = {}
    parsed_data[:description] = course_json["courseDescription"]
    parsed_data[:title] = course_json["title"]
    parsed_data[:course_data] = course_data
    parsed_data[:corequisite] = course_json["corequisite"]
    parsed_data[:prerequisite] = course_json["prerequisite"]
    parsed_data
  end
end
