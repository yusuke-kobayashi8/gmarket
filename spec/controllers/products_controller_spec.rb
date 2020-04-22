require 'rails_helper'

describe ProductsController, type: :controller  do
  let(:user) {create(:user)}

  describe 'GET #index' do
    it "商品一覧ページに遷移するか" do
      login_user user
      get :index
      expect(response).to render_template :index
    end
    it "インスタンス変数が期待したものになるか" do
      products = create_list(:product, 1)
      get :index
      expect(assigns(:products)).to eq products #match(products.sort{ |a, b| b.created_at <=> a.created_at } )
    end
  end
