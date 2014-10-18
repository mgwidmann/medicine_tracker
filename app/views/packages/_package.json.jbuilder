json.extract! package, :id, :name, :serial, :created_at, :updated_at
json.drugs package.drugs, partial: 'drugs/drug', as: :drug
json.url package_url(package, format: :json)
