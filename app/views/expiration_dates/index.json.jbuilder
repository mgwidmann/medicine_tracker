json.array!(@expiration_dates) do |expiration_date|
  json.partial! 'expiration_dates/expiration_date', expiration_date: expiration_date
end
