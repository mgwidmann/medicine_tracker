json.extract! expiration_date, :id, :date, :created_at, :updated_at, :drug_id
json.url package_drug_expiration_date_url(@package, @drug, expiration_date, format: :json)
json.drug_url package_drug_url(@package, @drug, format: :json)
