json.array!(@medals) do |medal|
  json.extract! medal, :id, :name, :description, :score, :image
  json.url medal_url(medal, format: :json)
end
