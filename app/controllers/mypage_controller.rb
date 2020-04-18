class MypageController < ApplicationController
  before_action :authenticate_user!
  before_action :certification

  def show
  end

  private

  def certification
    @user = User.find(params[:id])
  end
end