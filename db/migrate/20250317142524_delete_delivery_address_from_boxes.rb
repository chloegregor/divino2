class DeleteDeliveryAddressFromBoxes < ActiveRecord::Migration[7.1]
  def change
    remove_column :boxes, :delivery_address
  end
end
