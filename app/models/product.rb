class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user, optional: true
  belongs_to :brand, optional: true
  belongs_to :category, optional: true
  belongs_to :purchaser, class_name: 'User', foreign_key: :purchaser_id, optional: true
  
  belongs_to_active_hash :status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :delivery_cost
  belongs_to_active_hash :days_to_ship
  
  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  validates_associated :images
  validates :images, presence: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :detail, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :status_id, :delivery_cost_id, :days_to_ship_id, :prefecture_id, presence: true
end
