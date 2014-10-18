class Package < ActiveRecord::Base

  has_many :drugs, inverse_of: :package

  accepts_nested_attributes_for :drugs

  def expiration_date
    drugs.map(&:expiration_date).min
  end

end
