class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :destination
      t.string :lat
      t.string :long
      t.string :api_key

      t.timestamps
    end
  end
end
