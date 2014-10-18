class ReCreateUser < ActiveRecord::Migration
  def change
    drop_table(:users)
    create_table :users do |t|
      t.string :email
      t.string :password_hash
      t.string :password_salt
    end
  end
end
