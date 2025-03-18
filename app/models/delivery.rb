class Delivery < ApplicationRecord
  belongs_to :user
  belongs_to :address, optional: true

  def self.ransackable_attributes(auth_object = nil)
    ["address_id", "created_at", "delivery_method", "id", "id_value", "updated_at", "user_id"]
  end
end
