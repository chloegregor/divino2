class AddStockOwnerToBoxes < ActiveRecord::Migration[7.1]
  def change
    add_reference :boxes, :stock_owner, null: false, foreign_key: true
  end
end
