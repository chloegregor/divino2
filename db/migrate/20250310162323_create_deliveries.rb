class CreateDeliveries < ActiveRecord::Migration[7.1]
  def change
    create_table :deliveries do |t|
      t.string :delivery_method, null: false, default: 'pickup'
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
