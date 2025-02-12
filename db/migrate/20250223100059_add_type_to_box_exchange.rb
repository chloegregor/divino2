class AddTypeToBoxExchange < ActiveRecord::Migration[7.1]
  def change
    add_column :box_exchanges, :type, :string
  end
end
