class BoxExchange < ApplicationRecord
  belongs_to :exchange
  belongs_to :box

  validates :box_id, presence: { message: "must be selected" }


  def self.ransackable_attributes(auth_object = nil)
    ["box_id", "role", "created_at", "exchange_id", "id", "id_value", "updated_at"]
  end


end
