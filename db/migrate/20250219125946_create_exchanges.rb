class CreateExchanges < ActiveRecord::Migration[7.1]
  def change
    create_table :exchanges do |t|
      t.string :status
      t.integer :recipient_id
      t.integer :initiator_id

      t.timestamps
    end
  end
end
