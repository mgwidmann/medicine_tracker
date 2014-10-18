class Drug < ActiveRecord::Base

  belongs_to :package, inverse_of: :drugs
  has_many :expiration_dates, inverse_of: :drug

  accepts_nested_attributes_for :expiration_dates

  validates_presence_of :package

  def expiration_date
    expiration_dates.map(&:date).min
  end

end
