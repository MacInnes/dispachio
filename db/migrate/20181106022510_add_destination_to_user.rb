class AddDestinationToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :destination, :string
  end
end
