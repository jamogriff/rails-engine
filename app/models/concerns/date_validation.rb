require 'date'

module DateValidation

  def date_check(raw_data)
    Date.strptime(raw_data, "%Y-%m-%d") rescue false
  end

  def dates_present?
    params[:start_date].present? && params[:end_date].present?
  end

  def one_date_present?
    params[:start_date].present? || params[:end_date].present?
  end

  # Dates valid comes from InputValidation in concerns
  # Opportunity to refactor ***
  def dates_valid?
    date_check(params[:start_date]) && date_check(params[:end_date]) && dates_sequential?
  end

  def dates_sequential?
    start = date_check(params[:start_date])
    end_time = date_check(params[:end_date])
    start < end_time
  end
end
