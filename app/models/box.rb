class Box < ApplicationRecord
  belongs_to :user
  belongs_to :dividende
  has_one :vinyard, through: :dividende
  has_many :box_exchanges, dependent: :destroy
  has_many :exchanges, through: :box_exchanges
  belongs_to :address, optional: true
  belongs_to :stock_owner


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "updated_at", "user_id", "dividende_id", "delivery_method", "address_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["dividende", "user", "stock_owner"]
  end

end
