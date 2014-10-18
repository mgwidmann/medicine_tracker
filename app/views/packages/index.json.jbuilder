json.array!(@packages) do |package|
  json.extract! package, :id, :created_at, :updated_at
  json.drugs do
    json.array! package.drugs.map(&:name)
  end
  json.expiration_date package.expiration_date
  json.url package_url(package, format: :json)
end
