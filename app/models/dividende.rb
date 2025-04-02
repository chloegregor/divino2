class Dividende < ApplicationRecord
  belongs_to :vinyard
  has_many :boxes, dependent: :destroy
  has_many :users, through: :boxes
  has_many :dividende_cuvee_colors, dependent: :destroy
  has_many :cuvee_colors, through: :dividende_cuvee_colors
  has_many :cuvees, through: :cuvee_colors
  has_many :vinyard_appellations, through: :cuvees

  validates :year, presence: true
  validates :shipping_date, presence: true
  validates :value , presence: true , inclusion: { in: (0..3) }

  after_create :create_boxes

  scope :current_year, -> { where(year: Time.current.year) }

  accepts_nested_attributes_for :dividende_cuvee_colors, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "shipping_date","year", "updated_at", "vinyard_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["boxes", "cuvee_colors", "cuvees", "dividende_cuvee_colors", "users", "vinyard", "vinyard_appellations"]
  end

  def create_boxes
    self.vinyard.stock_owners.each do |stock_owner|
      puts "stock_owner.quantity: #{stock_owner.quantity}"
      stock_owner.quantity.times do
        puts "stock_owner.user: #{stock_owner.user}"

        box = Box.create(user: stock_owner.user, stock_owner: stock_owner, vinyard: self.vinyard, dividende: self)
        

        if box.persisted?
          puts "Box created: #{box.inspect}"
        else
          puts " Box not created: #{box.errors.full_messages}"
        end
      end
    end
  end
end
