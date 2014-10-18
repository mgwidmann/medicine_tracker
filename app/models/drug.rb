class Drug < ActiveRecord::Base

  belongs_to :package
  has_many :expiration_dates

  validates_presence_of :package

  def expiration_date
    expiration_dates.map(&:date).min
  end

end
