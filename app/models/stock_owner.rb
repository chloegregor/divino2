class StockOwner < ApplicationRecord
  belongs_to :vinyard
  belongs_to :user

  validates :quantity, presence: true
  after_create :create_boxes

  def self.ransackable_associations(auth_object = nil)
    ["user", "vinyard"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "quantity","id", "id_value", "updated_at", "user_id", "vinyard_id"]
  end

  def create_boxes
    latest_dividende = self.vinyard.dividendes.order(year: :desc).first
    return unless latest_dividende
    self.quantity.times do
      Box.create(user: self.user, vinyard: self.vinyard, dividende: latest_dividende)
    end
  end

end
