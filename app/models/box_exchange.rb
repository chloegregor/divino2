class BoxExchange < ApplicationRecord
  before_create :set_type

  belongs_to :exchange, inverse_of: :box_exchanges
  belongs_to :box

  def self.ransackable_attributes(auth_object = nil)
    ["box_id", "role", "created_at", "exchange_id", "id", "id_value", "updated_at"]
  end

  def set_type
    self.type = self.class.name
  end
end
