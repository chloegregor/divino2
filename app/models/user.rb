class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :boxes, dependent: :destroy
  has_many :dividendes, through: :boxes
  has_many :exchanges_as_initator, foreign_key: "initiator_id", class_name: "Exchange", dependent: :destroy
  has_many :exchanges_as_recipient, foreign_key: "recipient_id", class_name: "Exchange", dependent: :destroy
  has_many :stock_owners, dependent: :destroy
  has_many :vinyards, through: :stock_owners
  has_one :delivery, dependent: :destroy
  has_many :addresses, dependent: :destroy
  after_create :create_delivery



  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :boxes, allow_destroy: true

  def self.ransackable_associations(auth_object = nil)
    ["boxes", "dividendes", "exchanges_as_initator", "exchanges_as_recipient", "stock_owners", "vinyards", "delivery", "addresses"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "delivery_address", "id", "id_value", "pseudo", "updated_at",
     "email", "encrypted_password", "reset_password_token", "reset_password_sent_at",]
  end

  private

  def create_delivery
    Delivery.create(user: self)
  end

end
