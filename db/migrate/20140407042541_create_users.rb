class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :salt
      t.string :fish
      t.string :reset_code
      t.datetime :reset_expires_at

      t.timestamps
    end
  end
end