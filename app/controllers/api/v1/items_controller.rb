class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  def index
    if params[:merchant_id].present?
      merchant = Merchant.find(params[:merchant_id])
      @items = merchant.items
    else
      @items = Item.all.paginate(params[:page], params[:per_page])
    end
    json_response(ItemSerializer.new(@items))
  end

  def show
    json_response(ItemSerializer.new(@item))
  end

  def create
    @item = Item.create!(item_params)
    json_response(ItemSerializer.new(@item), :created)
  end

  def destroy
    @item.destroy
    head :no_content
  end

  def update
    @item.update!(item_params)
    # Originally returned 402 nocontent here, but not as user-friendly
    json_response(ItemSerializer.new(@item))
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
