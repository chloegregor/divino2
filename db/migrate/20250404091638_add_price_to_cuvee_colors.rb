class AddPriceToCuveeColors < ActiveRecord::Migration[7.1]
  def change
    add_column :cuvee_colors, :price, :decimal, precision: 10, scale: 2
    
  end
end
