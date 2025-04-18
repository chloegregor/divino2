class CuveeColor < ApplicationRecord
  belongs_to :cuvee
  belongs_to :color
  has_many :dividende_cuvee_colors, dependent: :destroy

  accepts_nested_attributes_for :color, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    ["color_id", "created_at", "cuvee_id", "description", "id", "id_value", "updated_at"]
  end
end
