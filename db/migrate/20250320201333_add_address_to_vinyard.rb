class AddAddressToVinyard < ActiveRecord::Migration[7.1]
  def change
    add_column :vinyards, :address, :string
  end
end
