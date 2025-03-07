class Dividende < ApplicationRecord
  belongs_to :vinyard
  has_many :boxes
  has_many :users, through: :boxes
  has_many :dividende_cuvee_colors
  has_many :cuvee_colors, through: :dividende_cuvee_colors
  has_many :cuvees, through: :cuvee_colors
  has_many :vinyard_appellations, through: :cuvees
  has_many :users, through: :boxes

  scope :current_year, -> { where(year: Time.current.year) }

  accepts_nested_attributes_for :dividende_cuvee_colors, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "year", "updated_at", "vinyard_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["boxes", "cuvee_colors", "cuvees", "dividende_cuvee_colors", "users", "vinyard", "vinyard_appellations"]
  end


end
