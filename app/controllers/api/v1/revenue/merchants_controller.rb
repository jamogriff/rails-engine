class Api::V1::Revenue::MerchantsController < ApplicationController

  # Needs to be fine-tuned slightly to account for sad path
  def index
    if params[:quantity].present?
      converted_num = Integer params[:quantity] # rasies exception if fail
      @merchants = Merchant.sort_by_revenue(converted_num)
    else
      @merchants = Merchant.sort_by_revenue
    end
    json_response(MerchantNameRevenueSerializer.new(@merchants))
  end

  def show
  end
end
