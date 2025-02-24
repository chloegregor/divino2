class CreateBoxes < ActiveRecord::Migration[7.1]
  def change
    create_table :boxes do |t|
      t.references :dividende, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
