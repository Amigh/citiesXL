json.array!(@students) do |student|
  json.extract! student, :id, :first_name, :last_name, :image, :score, :class_name, :class_number
  json.url student_url(student, format: :json)
end
