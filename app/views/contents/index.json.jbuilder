json.array!(@contents) do |content|
  json.extract! content, :id, :name, :attachment
  json.url content_url(content, format: :json)
end
