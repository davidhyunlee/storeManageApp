json.extract! sale_type, :id, :name, :description, :tracked, :created_at, :updated_at
json.url sale_type_url(sale_type, format: :json)