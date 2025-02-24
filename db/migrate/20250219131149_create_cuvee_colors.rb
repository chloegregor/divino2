class CreateCuveeColors < ActiveRecord::Migration[7.1]
  def change
    create_table :cuvee_colors do |t|
      t.references :cuvee, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
