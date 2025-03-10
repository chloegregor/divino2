class UpdateQuantityColumnOnStockOwner < ActiveRecord::Migration[7.1]
  def change
    change_column :stock_owners, :quantity, :integer, default:1
  end
end
