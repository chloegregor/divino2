class Box < ApplicationRecord
  belongs_to :user
  belongs_to :dividende
  has_one :vinyard, through: :dividende
  has_many :box_exchanges, dependent: :destroy
  has_many :exchanges, through: :box_exchanges


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "updated_at", "user_id", "dividende_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["dividende", "user"]
  end

end
