class Address < ApplicationRecord
  belongs_to :user
  has_many :deliveries, dependent: :nullify
  has_many :boxes, dependent: :nullify

  def self.ransackable_attributes(auth_object = nil)
    ["city", "country", "created_at", "id", "id_value", "name", "street", "title", "updated_at", "user_id", "zip"]
  end
  
end
