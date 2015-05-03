require "csv"

class CreateCourseService
  def call
    course_data = parse_course_data_into_array
    counter = 0
    course_data.each do |course_row|
      attributes = attributes_from(course_row)
      course = Course.find_or_create_by!(department: attributes[:department],
                                         level: attributes[:level]) do |course|
        course.title = attributes[:title]
        course.description = attributes[:description]
        course.degree_requirement = attributes[:degree_requirement]
      end
      puts "CREATED COURSE: #{ course.full_id }"
      counter += 1
    end
  end

  private

    def parse_course_data_into_array
      body = File.read("lib/assets/tbl_Course.csv")
      CSV::Converters[:blank_to_nil] = lambda do |field|
        field && field.empty? ? nil : field
      end
      csv = CSV.new(body, headers: true,
                          header_converters: :symbol,
                          converters: [:all, :blank_to_nil])
      csv.to_a.map(&:to_hash)
    end

    def degree_requirement_converter(old_value)
      case old_value
      when "Required Courses"
        0
      when "Distribution Requirements"
        1
      when "Free Electives"
        2
      else
        fail ArgumentError, "Couldn't find a match for CSV degree
                             requirement value"
      end
    end

    def attributes_from(course_row)
      a = {}
      a[:department] = course_row[:department]
      a[:level] = course_row[:level]
      a[:title] = course_row[:title]
      a[:description] = course_row[:description]
      deg_req = degree_requirement_converter(course_row[:degree_requirement])
      a[:degree_requirement] = deg_req
      a
    end
end
