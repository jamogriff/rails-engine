class Api::V1::Merchants::SearchesController < ApplicationController

  def show
    if params[:name].present?
      @merchant = Merchant.find_by_name(params[:name])

      # Helper method would be useful to check whether results are empty or not
      if @merchant.nil?
        json_response({data: [], message: "No results"})
      else
        json_response(MerchantSerializer.new(@merchant))
      end
    else
      json_response({message: "Please provide search parameters"}, :bad_request)
    end
  end

end
