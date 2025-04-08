class CreatePickUpDates < ActiveRecord::Migration[7.1]
  def change
    create_table :pick_up_dates do |t|
      t.date :date
      t.references :box, null: false, foreign_key: true

      t.timestamps
    end
  end
end
