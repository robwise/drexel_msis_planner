class CreateCourseService
  def call
    course = course.find_or_create_by!(department: 'INFO', level: '530') do |course|
      course.title = 'Foundations of Information Systems'
      course.description = 'Some descriptive text about the course.'
      course.confirm!
    end
  end
end