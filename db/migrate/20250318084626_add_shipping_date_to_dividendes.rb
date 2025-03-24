class AddShippingDateToDividendes < ActiveRecord::Migration[7.1]
  def change
    add_column :dividendes, :shipping_date, :date
  end
end
