class CreateStockOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_owners do |t|
      t.references :vinyard, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
