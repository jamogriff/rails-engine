module ExceptionHandler
  # access more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: "Query unable to be resolved.",
                      error: e.message }, :not_found)
    end

    # used when #save! or #create! fail
    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message:  "Record unable to be processed.",
                      error: e.message }, :unprocessable_entity)
    end

    # Used when a user enters wrong data type as a parameter
    rescue_from ArgumentError do |e|
      json_response({ message: "Please enter correct data type.",
                      error: e.message }, :bad_request)
    end
  end

end
