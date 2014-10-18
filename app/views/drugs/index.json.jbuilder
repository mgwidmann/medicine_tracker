json.array!(@drugs) do |drug|
  json.partial! 'drugs/drug', drug: drug
end
