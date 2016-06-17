json.array!(@containers) do |container|
  json.extract! container, :id
  json.url container_url(container, format: :json)
end
