class Vinyard < ApplicationRecord
  has_many :vinyard_appellations
  has_many :appellations, through: :vinyard_appellations
  has_many :cuvees, through: :vinyard_appellations
  has_many :cuvee_colors, through: :cuvees
  has_many :colors, through: :cuvee_colors
  has_many :dividendes
  has_many :boxes, through: :dividendes
  has_many :stock_owners
  has_many :users, through: :stock_owners
  belongs_to :admin, class_name: "User", foreign_key: "admin_id", optional: true

  after_save :define_admin

  accepts_nested_attributes_for :dividendes, allow_destroy: true

  accepts_nested_attributes_for :vinyard_appellations, allow_destroy: true

  accepts_nested_attributes_for :stock_owners, allow_destroy: true



  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id","address", "id_value", "name", "admin_id", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["appellations", "cuvees", "vinyard_appellations", "cuvee_colors", "colors", "dividendes", "boxes", "stock_owners", "users"]
  end

  def define_admin
    admin = User.find_by_id(self.admin_id)
    admin&.admin!
  end

end
