class Vinyard < ApplicationRecord
  has_many :vinyard_appellations
  has_many :appellations, through: :vinyard_appellations
  has_many :cuvees, through: :vinyard_appellations
  has_many :cuvee_colors, through: :cuvees
  has_many :colors, through: :cuvee_colors
  has_many :dividendes
  has_many :boxes, through: :dividendes

  accepts_nested_attributes_for :dividendes, allow_destroy: true

  accepts_nested_attributes_for :vinyard_appellations, allow_destroy: true


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["appellations", "cuvees", "vinyard_appellations", "cuvee_colors", "colors", "dividendes", "boxes"]
  end

end
