class AddRoleToBoxExchanges < ActiveRecord::Migration[7.1]
  def change
    add_column :box_exchanges, :role, :string
  end
end
