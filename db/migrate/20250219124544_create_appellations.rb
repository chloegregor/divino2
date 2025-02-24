class CreateAppellations < ActiveRecord::Migration[7.1]
  def change
    create_table :appellations do |t|
      t.string :name

      t.timestamps
    end
  end
end
