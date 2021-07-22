class RevenueController < ApplicationController

  def index
    if params[:start_time].present? && params[:end_time].present?
      InputValidation.date(params[:start_time])
      InputValidation.date(params[:end_time])
    end
  end
end
