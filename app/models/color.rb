class Color < ApplicationRecord
  has_many :cuvee_colors
  has_many :dividende_cuvee_colors, through: :cuvee_colors
  has_many :cuvees, through: :cuvee_colors
  has_many :vinyards, through: :vinyard_appellation

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "color", "updated_at"]
  end

end
