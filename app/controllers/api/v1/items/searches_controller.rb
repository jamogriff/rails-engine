class Api::V1::Items::SearchesController < ApplicationController

  def index
    if params[:name].present?
      @item = Item.find_all(params[:name])
      json_response(ItemSerializer.new(@item))
    else
      json_response({message: "Please provide search parameters"}, :bad_request)
    end
  end

end
