class AddDestinationToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :destination, :string, :default => '1331 17th Street, Denver, CO 80301'
  end
end
