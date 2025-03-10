class AddColumnsToBoxes < ActiveRecord::Migration[7.1]
  def change
    add_column :boxes, :exchangeable, :boolean
    add_column :boxes, :delivery_method, :string
    add_column :boxes, :delivery_address, :string
  end
end
