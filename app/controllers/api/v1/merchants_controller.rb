class Api::V1::MerchantsController < ApplicationController

  # GET /api/v1/merchants
  def index
    @merchants = Merchant.all
    render json: MerchantSerializer.new(@merchants)
  end

  # GET /api/v1/merchants/:id
  def show
  end

end
