require "rails_helper"

RSpec.describe Product, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with complete form' do
        expect(build(:product)).to be_valid
      end

      it 'is valid with multipul images' do
        expect(build(:product_multipul_images)).to be_valid
      end

      it 'is valid without brand' do
        expect(build(:product, brand: nil)).to be_valid
      end
    end

    context 'can not save' do
      it 'is invalid without user' do
        product = build(:product, user_id: nil)
        product.valid?
        expect(product.errors[:user]).to include("を入力してください")
      end

      it 'is invalid without images' do
        product = build(:product_without_images)
        product.valid?
        expect(product.errors[:images]).to include("を入力してください")
      end

      it 'is invalid without name' do
        product = build(:product, name: nil)
        product.valid?
        expect(product.errors[:name]).to include("を入力してください")
      end

      it 'is invalid without price' do
        product = build(:product, price: nil)
        product.valid?
        expect(product.errors[:price]).to include("を入力してください")
      end

      it 'is invalid without detail' do
        product = build(:product, detail: nil)
        product.valid?
        expect(product.errors[:detail]).to include("を入力してください")
      end

      it 'is invalid without status' do
        product = build(:product, status_id: nil)
        product.valid?
        expect(product.errors[:status_id]).to include("を入力してください")
      end

      it 'is invalid without delivery_cost' do
        product = build(:product, delivery_cost_id: nil)
        product.valid?
        expect(product.errors[:delivery_cost_id]).to include("を入力してください")
      end

      it 'is invalid without days_to_ship' do
        product = build(:product, days_to_ship_id: nil)
        product.valid?
        expect(product.errors[:days_to_ship_id]).to include("を入力してください")
      end

      it 'is invalid without prefecture' do
        product = build(:product, prefecture_id: nil)
        product.valid?
        expect(product.errors[:prefecture_id]).to include("を入力してください")
      end

      it 'is invalid without category' do
        product = build(:product, category_id: nil)
        product.valid?
        expect(product.errors[:category_id]).to include("を入力してください")
      end
    end

    context 'boundary test' do
      it 'is valid with price over 300' do
        expect(build(:product, price: 300)).to be_valid
      end

      it 'is invalid with price under 299' do
        product = build(:product, price: 299)
        product.valid?
        expect(product.errors[:price]).to include("は300以上の値にしてください")
      end

      it 'is valid with price under 9,999,999' do
        expect(build(:product, price: 9999999)).to be_valid
      end

      it 'is invalid with price over 10,000,000' do
        product = build(:product, price: 10000000)
        product.valid?
        expect(product.errors[:price]).to include("は9999999以下の値にしてください")
      end

      it 'is valid with detail length under 1000' do
        expect(build(:product, detail: Faker::Lorem.paragraph_by_chars(number: 1000, supplemental: false))).to be_valid
      end

      it 'is invalid with detail length over 1000' do
        product = build(:product, detail: Faker::Lorem.paragraph_by_chars(number: 1001, supplemental: false))
        product.valid?
        expect(product.errors[:detail]).to include("は1000文字以内で入力してください")
      end
    end
  end
end