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
    # Check to see if param is an actual number; throws ArgumentError if not
    converted_num = Integer params[:id]
    # Check to see if params links to actual Merchant; throws RecordNotFound if not
    Merchant.find(converted_num)
    # Provided the above are valid, then return data
    @merchant = Merchant.get_revenue_from(converted_num)
    json_response(MerchantNameRevenueSerializer.new(@merchant))
  end
end
