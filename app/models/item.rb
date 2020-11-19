class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  has_one :purchase
  belongs_to :brand
  belongs_to :category
  has_one_active_hash :cost
  has_one_active_hash :days_to_ship
  belongs_to :seller, class_name: :user
  belongs_to :buyer, class_name: :user
end
