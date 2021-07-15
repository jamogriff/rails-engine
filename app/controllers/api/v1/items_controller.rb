class Api::V1::ItemsController < ApplicationController

  def index
    if params[:merchant_id].present?
      merchant = Merchant.find(params[:merchant_id])
      @items = merchant.items
    else
      @items = Item.all
    end
    json_response(ItemSerializer.new(@items))
  end

end
