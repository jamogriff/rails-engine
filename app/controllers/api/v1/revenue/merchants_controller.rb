class Api::V1::Revenue::MerchantsController < ApplicationController

  # Needs to be fine-tuned slightly to account for sad path
  def index
    if params[:quantity].present?
      @merchants = Merchant.sort_by_revenue(params[:quantity].to_i)
    else
      @merchants = Merchant.sort_by_revenue
    end
    json_response(MerchantNameRevenueSerializer.new(@merchants))
  end

  def show
  end
end
