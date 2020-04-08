class CreditCardsController < ApplicationController

  require "payjp"
  before_action :set_card

  def index
    # すでにクレジットカードが登録しているか？
    if @card.present?
      # 登録している場合,PAY.JPからカード情報を取得する
      # PAY.JPの秘密鍵をセットする。
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      # PAY.JPから顧客情報を取得する。
      customer = Payjp::Customer.retrieve(@card.payjp_id)
      # PAY.JPの顧客情報から、デフォルトで使うクレジットカードを取得する。
      @card_info = customer.cards.retrieve(customer.default_card)
      # クレジットカード情報から表示させたい情報を定義する。
      # クレジットカードの画像を表示するために、カード会社を取得
      @card_brand = @card_info.brand
      # クレジットカードの有効期限を取得
      @exp_month = @card_info.exp_month.to_s
      @exp_year = @card_info.exp_year.to_s.slice(2,3) 

      # クレジットカード会社を取得したので、カード会社の画像をviewに表示させるため、ファイルを指定する。
      case @card_brand
      when "Visa"
        @card_image = "visa.svg"
      when "JCB"
        @card_image = "jcb.svg"
      when "MasterCard"
        @card_image = "master-card.svg"
      when "American Express"
        @card_image = "american_express.svg"
      when "Diners Club"
        @card_image = "dinersclub.svg"
      when "Discover"
        @card_image = "discover.svg"
      end
    end
  end

  def new
    # cardがすでに登録済みの場合、indexのページに戻します。
    @card = Creditcard.where(user_id: current_user.id).first
    redirect_to action: "index" if @card.present?    
  end

  def create
    # PAY.JPの秘密鍵をセット（環境変数）
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]

    # jsで作成したpayjpTokenがちゃんと入っているか？
    if params['payjpToken'].blank?
      # トークンが空なら戻す
      render "new"
    else
      # トークンがちゃんとあれば進めて、PAY.JPに登録されるユーザーを作成します。
      customer = Payjp::Customer.create(
        description: 'test',
        email: current_user.email,
        card: params['payjpToken'],
        metadata: {user_id: current_user.id}
      )

      # PAY.JPのユーザーが作成できたので、creditcardモデルを登録します。
      @card = Creditcard.new(user_id: current_user.id, payjp_id: customer.id)
      if @card.save
        redirect_to action: "index", notice:"支払い情報の登録が完了しました"
      else
        render 'new'
      end
    end
  end

  def destroy     
    # 今回はクレジットカードを削除するだけでなく、PAY.JPの顧客情報も削除する。これによりcreateメソッドが複雑にならない。
    # PAY.JPの秘密鍵をセットして、PAY.JPから情報をする。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    # PAY.JPの顧客情報を取得
    customer = Payjp::Customer.retrieve(@card.payjp_id)
    customer.delete # PAY.JPの顧客情報を削除
    if @card.destroy # App上でもクレジットカードを削除
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  private
  def set_card
    @card = Creditcard.where(user_id: current_user.id).first if Creditcard.where(user_id: current_user.id).present?
  end

end
