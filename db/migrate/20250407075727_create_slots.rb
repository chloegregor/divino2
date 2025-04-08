class CreateSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :slots do |t|
      t.date :start_date
      t.date :end_date
      t.references :dividende, null: false, foreign_key: true

      t.timestamps
    end
  end
end
