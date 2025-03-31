class Cuvee < ApplicationRecord
  belongs_to :vinyard_appellation
  has_many :cuvee_colors, dependent: :destroy
  has_many :dividende_cuvee_colors, through: :cuvee_colors
  has_many :colors, through: :cuvee_colors
  has_many :dividendes, through: :dividende_cuvee_colors

  accepts_nested_attributes_for :cuvee_colors, allow_destroy: true

  before_validation :downcase_name
  validates :name, presence: true, uniqueness: { scope: :vinyard_appellation_id }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "name", "updated_at", "vinyard_appellation_id"]
  end

  def downcase_name
    self.name = self.name.downcase
  end

end
