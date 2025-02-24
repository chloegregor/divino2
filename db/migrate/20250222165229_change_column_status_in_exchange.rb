class ChangeColumnStatusInExchange < ActiveRecord::Migration[7.1]
  def change
    change_column :exchanges, :status, :string, default: "pending"
  end
end
