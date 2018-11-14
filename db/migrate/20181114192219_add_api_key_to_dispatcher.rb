class AddApiKeyToDispatcher < ActiveRecord::Migration[5.2]
  def change
    add_column :dispatchers, :api_key, :string
  end
end
