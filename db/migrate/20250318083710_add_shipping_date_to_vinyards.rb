class AddShippingDateToVinyards < ActiveRecord::Migration[7.1]
  def change
    add_column :vinyards, :shipping_date, :date
  end
end
