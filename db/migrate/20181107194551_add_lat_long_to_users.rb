class AddLatLongToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :latitude, :string
    add_column :users, :longitude, :string
  end
end
