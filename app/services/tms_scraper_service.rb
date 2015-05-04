# Calls the Drexel-TMS-Scraper external API to get latest course data and
# then update this app's corresponding data
class TMSScraperService
  require "httparty"

  SCRAPER_URL = "https://nameless-tor-6040.herokuapp.com/course/"

  def update_all_courses
    update_courses(Course.pluck(:level))
  end

  def update_courses(course_levels)
    course_levels.each do |course_level|
      update_course(course_level)
    end
  end

  # Can take either an object responding to :level or a level directly
  def update_course(argument)
    course_level = get_course_level_from_argument(argument)
    parsed_data = request_course_data_from_external_api(course_level)
    use_data_to_update_course_attributes(course_level, parsed_data)

    rescue TMSScraperException => e
      Rails.logger.error(e.message + "\n" + e.backtrace.inspect)
    rescue ActiveRecord::RecordInvalid => e
      errors = ""
      e.record.errors.full_messages.each do |message|
        errors << (message.to_s + "\n")
      end
      Rails.logger.error("TMS Scraper Service: encountered #{e.message}.\n" +
        errors + e.backtrace.inspect)
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error("TMS Scraper Service: encountered #{e.message}.\n" +
                         e.backtrace.inspect)
  end

  private

  def get_course_level_from_argument(argument)
    argument.respond_to?(:level) ? argument.level : argument
  end

  def request_course_data_from_external_api(course_level)
    response = HTTParty.get(SCRAPER_URL + course_level.to_s)
    unless response.response.code == "200"
      fail TMSScraperException, "TMS Scraper Service: course retrieval from"\
        " TMS Scraper API failed for course level #{ course_level }."\
        " Received response #{ response.response.code }.", caller
    end
    parse_response(response)
  end

  # Converts HTTParty's parsed_response method to using symbol keys and our
  # own terminology if different.
  def parse_response(response)
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

  def use_data_to_update_course_attributes(course_level, parsed_data)
    course = Course.find_by!(level: course_level)
    course.update!(parsed_data[:course_data])
    update_requisite_with_data(course, :prerequisite, parsed_data)
    update_requisite_with_data(course, :corequisite, parsed_data)
  end

  # While there shouldn't be nil values anywhere, the others will be caught by
  # ActiveModel validations, but requisites will just get overridden by a blank
  # string, which is not the desired behavior in this case.
  def update_requisite_with_data(course, requisite_type, parsed_data)
    requisite_text = parsed_data[requisite_type]
    if requisite_text.nil?
      fail TMSScraperException,
           "Encountered abnormal data during retrieval from TMS Scraper API."\
             " #{ course.full_id }'s #{ requisite_type } was nil.",
           caller
    end
    course.update!(requisite_type => requisite_text)
  end
end

class TMSScraperException < StandardError
end
