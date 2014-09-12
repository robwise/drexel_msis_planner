class CreateCourseService
  def call
    Course.find_or_create_by!(department: 'INFO', level: '530') do |course|
      course.title = 'Foundations of Information Systems'
      course.description = 'Some descriptive text about the course.'
      course.degree_requirement = :required_course
    end
    Course.find_or_create_by!(department: 'INFO', level: '532') do |course|
      course.title = 'Software Development'
      course.description = 'Some descriptive text about the course.'
      course.degree_requirement = :required_course
    end
  end
end