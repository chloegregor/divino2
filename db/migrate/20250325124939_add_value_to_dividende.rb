class AddValueToDividende < ActiveRecord::Migration[7.1]
  def change
    add_column :dividendes, :value, :integer
  end
end
