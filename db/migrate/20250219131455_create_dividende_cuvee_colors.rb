class CreateDividendeCuveeColors < ActiveRecord::Migration[7.1]
  def change
    create_table :dividende_cuvee_colors do |t|
      t.integer :bottle_quantity
      t.references :dividende, null: false, foreign_key: true
      t.references :cuvee_color, null: false, foreign_key: true

      t.timestamps
    end
  end
end
