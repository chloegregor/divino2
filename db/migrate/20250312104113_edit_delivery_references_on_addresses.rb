class EditDeliveryReferencesOnAddresses < ActiveRecord::Migration[7.1]
  def change
    remove_reference :addresses, :delivery, null: false, foreign_key: true
  end
end
