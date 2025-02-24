class CreateDividendes < ActiveRecord::Migration[7.1]
  def change
    create_table :dividendes do |t|
      t.references :vinyard, null: false, foreign_key: true
      t.integer :year

      t.timestamps
    end
  end
end
