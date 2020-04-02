class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :postal_code, :prefectures, :city, :address, :posting_family_name, :posting_first_name, :posting_family_name_f, :posting_family_name_f, presence: true
end
