class Api::V1::RevenueController < ApplicationController
  def index
    # Happy path
    if dates_present? && dates_valid?
      @revenue = Merchant.revenue_between(params[:start_date], params[:end_date])
      json_response(RevenueSerializer.new(@revenue))
    elsif one_date_present?
      json_response({ message: "Please enter valid start and end dates in YYYY-MM-DD format."}, :bad_request)
    # Default behavior when no query params sent
    elsif !dates_present?
      @revenue = Merchant.total_revenue
      json_response(RevenueSerializer.new(@revenue))
    else
      json_response({ message: "Please enter valid start and end dates in YYYY-MM-DD format."}, :bad_request)
    end
  end
end
