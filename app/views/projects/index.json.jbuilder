json.array!(@projects) do |project|
  json.extract! project, :id, :population, :cash_flow, :income, :money, :satis_people_1, :satis_work_1
  json.url project_url(project, format: :json)
end
