class Appellation < ApplicationRecord
  has_many :vinyard_appellations
  has_many :vinyards, through: :vinyard_appellations
  has_many :cuvees, through: :vinyard_appellations

  accepts_nested_attributes_for :cuvees, allow_destroy: true


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at vinyard_appellations"]
  end
end
