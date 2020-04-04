class Product < ApplicationRecord
  has_many :images
  belongs_to :user
  belongs_to :brand, optional: true
  belongs_to :category
  has_one :order

  validates :name, :price, :detail, :status, :derivery_cost_id, :days_to_ship_id, :prefecture_id, presence: true
end
