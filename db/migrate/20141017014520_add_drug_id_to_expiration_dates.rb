class AddDrugIdToExpirationDates < ActiveRecord::Migration
  def change
    add_column :expiration_dates, :drug_id, :integer
    add_index :expiration_dates, :drug_id
  end
end
