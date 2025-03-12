class AddAddressReferencesOnDelivery < ActiveRecord::Migration[7.1]
  def change
    add_reference :deliveries, :address, null: true, foreign_key: true
  end
end
