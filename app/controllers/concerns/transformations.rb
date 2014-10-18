module Transformations
  extend ActiveSupport::Concern

  EXPIRATION_DATES = {expiration_dates: []}
  DRUGS = {drugs: [:id, :name, EXPIRATION_DATES]}

  def transform_drugs(package)
    # Transform the parameters to how Rails is expecting them
    (package[:drugs] || []).map! do |drug|
      transform_expiration_dates(drug)
    end
    package[:drugs_attributes] = package.delete(:drugs) if package[:drugs] # Rename
    package
  end

  def transform_expiration_dates(drug)
    (drug[:expiration_dates] || []).map! do |date|
      {date: date}
    end
    drug[:expiration_dates_attributes] = drug.delete(:expiration_dates) if drug[:expiration_dates]
    drug.permit(:id, :name, {expiration_dates_attributes: [:date]}, :package_id)
  end

end
