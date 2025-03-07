class AddQuantityToStockOwner < ActiveRecord::Migration[7.1]
  def change
    add_column :stock_owners, :quantity, :integer
  end
end
