class Api::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :update, :destroy]

  # GET /api/v1/merchants
  def index
    @merchants = Merchant.paginate(params[:page], params[:per_page])
    json_response(MerchantSerializer.new(@merchants))
  end

  # GET /api/v1/merchants/:id
  def show
    json_response(MerchantSerializer.new(@merchant))
  end

  private

  def merchant_params
    # access nested resource and whitelist params
    params.require(:merchant).permit(:name)
  end

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

end
