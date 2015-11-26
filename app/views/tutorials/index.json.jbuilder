json.array!(@tutorials) do |tutorial|
  json.extract! tutorial, :id, :title, :description, :video
  json.url tutorial_url(tutorial, format: :json)
end
