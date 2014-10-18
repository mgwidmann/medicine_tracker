class AddPackageIdToDrug < ActiveRecord::Migration
  def change
    add_column :drugs, :package_id, :integer
    add_index :drugs, :package_id
  end
end
