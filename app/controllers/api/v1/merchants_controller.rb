class Api::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :update, :destroy]

  # GET /api/v1/merchants
  def index
    @merchants = Merchant.paginate(params[:page], params[:per_page])
    render json: MerchantSerializer.new(@merchants)
  end

  # GET /api/v1/merchants/:id
  def show
    render json: MerchantSerializer.new(@merchant)
  end

  private

  def merchant_params
    # access nested resource and whitelist params
    params.require(:merchant).permit(:name)
  end

  def set_merchant
    #binding.pry
    @merchant = Merchant.find(params[:id])
  end

end
