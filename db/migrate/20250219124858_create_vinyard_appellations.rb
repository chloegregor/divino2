class CreateVinyardAppellations < ActiveRecord::Migration[7.1]
  def change
    create_table :vinyard_appellations do |t|
      t.references :vinyard, null: false, foreign_key: true
      t.references :appellation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
