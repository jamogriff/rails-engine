module ExceptionHandler
  # access more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: "Sorry, #{e.message}" }, :not_found)
    end

    # used when #save! or #create! fail
    rescue_from ActiveREcord::RecordInvalid do |e|
      json_response({ message: "Sorry, #{e.message}" }, :unprocessable_entity)
    end
  end

end
