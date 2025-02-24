class CreateBoxExchanges < ActiveRecord::Migration[7.1]
  def change
    create_table :box_exchanges do |t|
      t.references :exchange, null: false, foreign_key: true
      t.references :box, null: false, foreign_key: true

      t.timestamps
    end
  end
end
