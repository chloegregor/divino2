class ChangeVinyardColumn < ActiveRecord::Migration[7.1]
  def change
    change_column :vinyards, :description, :text, null: false
  end
end
