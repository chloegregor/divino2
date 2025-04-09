class Box < ApplicationRecord
  belongs_to :user
  belongs_to :dividende
  has_one :vinyard, through: :dividende
  has_many :box_exchanges, dependent: :destroy
  has_many :exchanges, through: :box_exchanges
  belongs_to :address, optional: true
  belongs_to :stock_owner
  has_one :pick_up_date, dependent: :destroy

  before_create :define_delivery_method

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "updated_at", "user_id", "dividende_id", "delivery_method", "address_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["dividende", "user", "stock_owner"]
  end

  def define_delivery_method
    if self.user.delivery.address
      self.delivery_method = "shipment"
      self.address = self.user.delivery.address
    else
      self.delivery_method = "pickup"
      self.build_pick_up_date = PickUpDate.new(date: self.dividende.slots.first.start_date)
    end
  end

end
