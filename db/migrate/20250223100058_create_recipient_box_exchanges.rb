class CreateRecipientBoxExchanges < ActiveRecord::Migration[7.1]
  def change
    create_table :recipient_box_exchanges do |t|

      t.timestamps
    end
  end
end
