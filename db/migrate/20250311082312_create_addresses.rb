class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :street
      t.string :zip
      t.string :country
      t.references :delivery, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
