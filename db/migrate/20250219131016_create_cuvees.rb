class CreateCuvees < ActiveRecord::Migration[7.1]
  def change
    create_table :cuvees do |t|
      t.references :vinyard_appellation, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
