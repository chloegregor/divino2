class VinyardAppellation < ApplicationRecord
  belongs_to :vinyard
  belongs_to :appellation
  has_many :cuvees, dependent: :destroy
  has_many :cuvee_colors, through: :cuvees

  accepts_nested_attributes_for :cuvees, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    ["appellation_id", "created_at", "id", "id_value", "updated_at", "vinyard_id"]
  end
end
