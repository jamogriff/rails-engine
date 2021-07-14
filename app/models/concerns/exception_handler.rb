module ExceptionHandler
  # access more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      # will have to check if proper code gets passed
      # if not, then will have to create json_response
      render json: { message: "Sorry, #{e.message}" }
    end

    rescue_from ActiveREcord::RecordInvalid do |e|
      render json: { message: "Sorry, #{e.message}" }
    end
  end

end
