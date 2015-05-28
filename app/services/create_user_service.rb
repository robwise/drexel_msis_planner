class CreateUserService
  attr_reader :courses, :user

  def initialize
    @courses = Course.all.to_a
  end

  def call
    create_user
    create_plans
    create_taken_courses
    create_planned_courses
    return @user
  end

  private

  def create_user
    @user = User.find_or_create_by!(email: "fake_user1@example.com") do |user|
      user.name = "fake_user1"
      user.password = "please123"
      user.password_confirmation = "please123"
      user.confirm!
    end
  end

  def create_plans
    Plan.find_or_create_by!(name: "Fake Plan 1") do |plan|
      plan.user = @user
    end
    Plan.find_or_create_by!(name: "Fake Plan 2") do |plan|
      plan.user = @user
    end
    puts "CREATED 2 PLANS FOR USER: #{@user.email}"
  end

  def create_taken_courses
    taken_courses_for(201415)
    taken_courses_for(201425)
    taken_courses_for(201435)
    puts "CREATED 9 TAKEN COURSES FOR USER: #{@user.email}"
  end

  def create_planned_courses
    quarter = Quarter.current_quarter
    3.times do
      quarter = quarter.next_quarter
      planned_courses_for(quarter)
    end
    puts "CREATED 9 PLANNED COURSES FOR USER: #{@user.email}"
  end

  def planned_courses_for(quarter)
    3.times do
      PlannedCourse.find_or_create_by!(plan: @user.active_plan,
                                       course: @courses.pop) do |planned_course|
        planned_course.quarter = quarter.to_s
      end
    end
  end

  def taken_courses_for(quarter)
    3.times do
      TakenCourse.find_or_create_by!(user: @user,
                                     course: @courses.shift) do |taken_course|
        taken_course.quarter = quarter.to_s
        taken_course.grade = TakenCourse.grades.collect.to_a.sample[1]
      end
    end
  end
end
