class AddAdminIdToVineyard < ActiveRecord::Migration[7.1]
  def change
    add_reference :vinyards, :admin, null: true, foreign_key: { to_table: :users }
  end
end
