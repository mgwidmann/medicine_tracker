json.extract! drug, :id, :name, :created_at, :updated_at, :expiration_date, :package_id
json.url package_drug_url(@package, drug, format: :json)
json.package_url package_url(@package, format: :json)
