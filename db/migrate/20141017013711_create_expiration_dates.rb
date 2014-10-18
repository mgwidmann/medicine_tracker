class CreateExpirationDates < ActiveRecord::Migration
  def change
    create_table :expiration_dates do |t|
      t.date :date

      t.timestamps
    end
  end
end
