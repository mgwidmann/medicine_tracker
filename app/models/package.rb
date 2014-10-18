class Package < ActiveRecord::Base

  has_many :drugs

  def expiration_date
    drugs.map(&:expiration_date).min
  end

end
