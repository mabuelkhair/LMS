json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :name, :description, :attachment, :due_date
  json.url assignment_url(assignment, format: :json)
end
