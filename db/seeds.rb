# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

course_count = CreateCourseService.new.call
puts "CREATED #{ course_count } #{ 'COURSE'.pluralize(course_count).upcase }"

unless Rails.env.test?
  user = CreateAdminService.new.call
  puts "CREATED ADMIN USER: #{user.email}"
end

if Rails.env.development?
  user = CreateUserService.new.call
  puts "CREATED USER: #{user.email}"
end
