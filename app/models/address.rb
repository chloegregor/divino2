class Address < ApplicationRecord
  belongs_to :user
  has_many :deliveries, dependent: :nullify
  has_many :boxes, dependent: :nullify
end
