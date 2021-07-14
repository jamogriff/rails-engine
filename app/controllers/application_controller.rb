class ApplicationController < ActionController::API
  # this module lives in models/concerns
  include ExceptionHandler
end
