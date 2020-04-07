class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable,
          :validatable, password_length: 7..128,
                        email_regexp:  /\A\S+@\S+\.\S+\z/
  validates_format_of :family_name, with: /\A[ぁ-んァ-ン一-龥]/, message: "を全角で入力してください"
  validates_format_of :first_name, with: /\A[ぁ-んァ-ン一-龥]/, message: "を全角で入力してください"
  validates_format_of :family_name_kana, with: /\A[ァ-ンー－]+\z/, message: "を全角で入力してください"
  validates_format_of :first_name_kana, with: /\A[ァ-ンー－]+\z/, message: "を全角で入力してください"

  validates :nickname, :family_name, :first_name, :family_name_kana, :first_name_kana, :birthday, presence: true
  has_one :address
end
