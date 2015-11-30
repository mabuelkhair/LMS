json.array!(@create_courses) do |create_course|
  json.extract! create_course, :id
  json.url create_course_url(create_course, format: :json)
end
