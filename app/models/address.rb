class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user, optional: true
  belongs_to_active_hash :prefecture

  validates :postal_code, :prefecture_id, :city, :address, :posting_family_name, :posting_first_name, :posting_family_name_f, :posting_first_name_f, presence: true
end
