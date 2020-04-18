require 'rails_helper'
RSpec.describe Product, elasticsearch: true do

  describe '.es_search' do
    describe '検索ワードにマッチする商品の検索' do
      let!(:product_1) do
        create(:product, name: 'パン', detail: 'パン大好き')
      end

      before :each do
        Product.__elasticsearch__.import(refresh: true)
      end

      def search_product_ids
        Product.es_search(query).records.pluck(:id)
      end

      context '検索ワードがタイトルにマッチする場合' do
        let(:query) { 'パン' }

        it '検索ワードにマッチする商品を取得する' do
          expect(search_product_ids).to eq [product_1.id]
        end
      end
    end
  end
end

