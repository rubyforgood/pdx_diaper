json.array!(@donations) do |donation|
  json.extract! donation, :id
  json.url donation_url(donation, format: :json)
end
