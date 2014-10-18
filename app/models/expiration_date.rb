class ExpirationDate < ActiveRecord::Base

  belongs_to :drug

  validates_presence_of :drug

end
