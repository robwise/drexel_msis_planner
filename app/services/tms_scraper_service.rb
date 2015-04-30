class TMSScraperService
  require "httparty"
  require "json"

  SCRAPER_URL = "https://nameless-tor-6040.herokuapp.com/course/"

  def self.update_all_courses_with_scraped_data
    update_courses_with_scraped_data(Course.pluck(:level))
  end

  def self.update_courses_with_scraped_data(course_levels)
    course_levels.each do |course_level|
      update_course_with_scraped_data(course_level)
    end
  end

  def self.update_course_with_scraped_data(course_level)
    course_json = request_data_for_course(course_level)
    parsed_data = parse_course_json(course_json)
    return false if parsed_data.nil?
    course = Course.find_by(level: course_level)
    course.update!(parsed_data[:course_data])
    # course.prerequisite.update!(raw_text: parsed_data[:prerequisite])
    # course.corequisite.update!(raw_text: parsed_data[:corequisite])
  end

  private

  def self.request_data_for_course(course_level)
    HTTParty.get(SCRAPER_URL + course_level.to_s).response
  end

  def self.parse_course_json(response)
    return nil unless response.code == "200"

    course_json = JSON.parse response.body
    {
      course_data: {
        description: course_json["courseDescription"],
        title: course_json["title"]
      },
      corequisite: course_json["corequisite"],
      prerequisite: course_json["prerequisite"]
    }
  end
end
