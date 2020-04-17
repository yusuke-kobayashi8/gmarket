require 'rails_helper'

RSpec.describe Creditcard, type: :model do
  let(:creditcard) { FactoryBot.create(:creditcard) }
  describe '#create' do

    it "user_id,customer_id,card_idが存在すれば登録できること" do
      creditcard = build_stubbed(:creditcard)
      expect(creditcard).to be_valid
    end

    it "user_idが存在すれば登録できること" do
      creditcard = build(:creditcard, user_id: nil)
      creditcard.valid?
      expect(creditcard.errors[:user_id]).to include("を入力してください")
    end

    it "customer_idが存在すれば登録できること" do
      creditcard = build(:creditcard, customer_id: nil)
      creditcard.valid?
      expect(creditcard.errors[:customer_id]).to include("を入力してください")
    end

    it "card_idが存在すれば登録できること" do
      creditcard = build(:creditcard, card_id: nil)
      creditcard.valid?
      expect(creditcard.errors[:card_id]).to include("を入力してください")
    end
  end
end