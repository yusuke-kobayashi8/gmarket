class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user, optional: true
  belongs_to :brand, optional: true
  belongs_to :category, optional: true

 
  
  belongs_to_active_hash :status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_cost
  belongs_to_active_hash :days_to_ship
  
  has_one :order

  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  validates_associated :images
  validates :images, presence: true
  validates :name, :price, :status_id, :delivery_cost_id, :days_to_ship_id, :prefecture_id, presence: true
end
