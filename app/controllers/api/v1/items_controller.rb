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
    # Weird quirk of if user tries to update id they receive
    # a 204 status, but update doesn't actually take place.

    # Postman tests fail because initial get fails for some reason...
    # then other 3 tests fail because they don't account for 204 or 422
    @item.update!(item_params)
    head :no_content
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
