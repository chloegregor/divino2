class ChangeForeignKeyOnDeliveries < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :deliveries, :addresses
    add_foreign_key :deliveries, :addresses, on_delete: :nullify
  end
end
