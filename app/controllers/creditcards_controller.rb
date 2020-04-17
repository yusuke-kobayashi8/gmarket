class CreditcardsController < ApplicationController

  require "payjp"
  before_action :set_card

  def index 
    if @card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)

      @card_brand = @card_information.brand      
      case @card_brand
      when "Visa"
        @card_src = "visa.svg"
      when "JCB"
        @card_src = "jcb.svg"
      when "MasterCard"
        @card_src = "master-card.svg"
      when "American Express"
        @card_src = "american_express.svg"
      when "Diners Club"
        @card_src = "dinersclub.svg"
      when "Discover"
        @card_src = "discover.svg"
      end
    end
  end

  def new 
    card = Creditcard.find_by(user_id: current_user.id)
    redirect_to action: "index" if card.present?
  end

  def create 
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]

    if params['payjp-token'].blank?
      flash.now[:alert] = '登録に失敗しました。'
      render "new"
    else
      customer = Payjp::Customer.create(
        description: 'test', 
        email: current_user.email,
        card: params['payjp-token'], 
        metadata: {user_id: current_user.id} 
      )
      @card = Creditcard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def destroy 
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy 
      redirect_to action: "index", notice: "削除しました"
    else 
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  def buy
    @product = Product.find(params[:product_id])
    if @product.purchaser_id.present?
      redirect_back

    elsif @card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'

    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      Payjp::Charge.create(
      amount: @product.price,
      customer: @card.customer_id,
      currency: 'jpy',
      )
      if @product.update(purchaser_id: current_user.id)
        flash[:notice] = '購入しました。'
        redirect_to controller: 'products', action: 'index'
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: 'products', action: 'index'
      end
    end
  end

  private

  def set_card
    @card = Creditcard.where(user_id: current_user.id).first if Creditcard.where(user_id: current_user.id).present?
  end
end