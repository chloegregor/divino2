class Exchange < ApplicationRecord
  belongs_to :recipient , class_name: "User", foreign_key: "recipient_id"
  belongs_to :initiator , class_name: "User", foreign_key: "initiator_id"
  has_many :initiator_box_exchanges, -> { where(role: "initiator") }, class_name: "BoxExchange", inverse_of: :exchange, dependent: :destroy
  has_many :recipient_box_exchanges, -> { where(role: "recipient") }, class_name: "BoxExchange", inverse_of: :exchange, dependent: :destroy

  # has_many :initiator_boxes, through: :initiator_box_exchanges, source: :box
  # has_many :recipient_boxes, through: :recipient_box_exchanges, source: :box

  has_many :box_exchanges , dependent: :destroy
  accepts_nested_attributes_for :box_exchanges, reject_if: proc { |attributes| attributes['box_id'].blank? }
  has_many :boxes, through: :box_exchanges
  validates :recipient_id, :initiator_id, :status, presence: true

  accepts_nested_attributes_for :initiator_box_exchanges, allow_destroy: true
  accepts_nested_attributes_for :recipient_box_exchanges, allow_destroy: true

  validate :must_have_boxes_for_both_roles

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "initiator_id", "recipient_id", "status", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["box_exchanges", "boxes", "initiator", "recipient"]
  end

  def initiator_boxes
    box_exchanges.where(role: "initiator").map(&:box)
  end

  def recipient_boxes
    box_exchanges.where(role: "recipient").map(&:box)
  end

  def stock_owner_boxes
    b
  end


  def must_have_boxes_for_both_roles
    recipient_boxes = box_exchanges.select { |be| be.role == 'recipient' && be.box_id.present? }
    initiator_boxes = box_exchanges.select { |be| be.role == 'initiator' && be.box_id.present? }

    if recipient_boxes.empty? || initiator_boxes.empty?
      errors.add(:base, "Must have boxes for both roles")
    end
  end



end
