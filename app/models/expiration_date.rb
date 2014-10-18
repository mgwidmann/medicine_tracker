class ExpirationDate < ActiveRecord::Base

  belongs_to :drug, inverse_of: :expiration_dates

  validates_presence_of :drug

end
