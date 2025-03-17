class AddAdressReferencesToBoxes < ActiveRecord::Migration[7.1]
  def change
    add_reference :boxes, :address, foreign_key: true
  end
end
