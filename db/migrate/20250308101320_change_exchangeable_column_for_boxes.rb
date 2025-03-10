class ChangeExchangeableColumnForBoxes < ActiveRecord::Migration[7.1]
  def change
    change_column :boxes, :exchangeable, :boolean, default: false
  end
end
