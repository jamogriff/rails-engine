class Api::V1::Revenue::WeeklyController < ApplicationController

  def index
    @weekly = Merchant.weekly_revenue
    json_response(WeeklyRevenueSerializer.new(@weekly))
  end

end
