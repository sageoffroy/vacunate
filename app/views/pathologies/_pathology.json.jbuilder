json.extract! pathology, :id, :code, :priority, :description, :created_at, :updated_at
json.url pathology_url(pathology, format: :json)
