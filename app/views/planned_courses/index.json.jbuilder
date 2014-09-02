json.array!(@planned_courses) do |planned_course|
  json.extract! planned_course, :id, :plan_id, :course_id, :quarter
  json.url planned_course_url(planned_course, format: :json)
end
