json.array!(@projects) do |project|
  json.extract! project, :id, :name, :information
  json.url project_url(project, format: :json)
end
