class AddRegionToVinyard < ActiveRecord::Migration[7.1]
  def change
    add_column :vinyards, :region, :string
  end
end
