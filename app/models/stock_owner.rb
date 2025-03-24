class StockOwner < ApplicationRecord
  belongs_to :vinyard
  belongs_to :user
  has_many :boxes

  validates :quantity, presence: true
  after_create :create_boxes

  def self.ransackable_associations(auth_object = nil)
    ["user", "vinyard", "boxes"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "quantity","id", "id_value", "updated_at", "user_id", "vinyard_id"]
  end

  def create_boxes
    latest_dividende = self.vinyard.dividendes.order(year: :desc).first
    return unless latest_dividende
    boxes = []
    self.quantity.times do
    boxes <<  Box.create(user: self.user, vinyard: self.vinyard, stock_owner: self, dividende: latest_dividende)
      if self.delivery.address.present?
        boxes.each do |box|
        box.update(address_id: self.delivery.address, delivery_method: self.delivery.delivery_method)
        end
      else
        boxes.each do |box|
        box.update(delivery_method: self.delivery.delivery_method)
        end
      end
    end
  end

end
