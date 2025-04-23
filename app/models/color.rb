class Color < ApplicationRecord
  has_many :cuvee_colors
  # has_many :dividende_cuvee_colors, through: :cuvee_colors
  has_many :cuvees, through: :cuvee_colors

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "color", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["cuvee_colors", "cuvees"]
  end

end
