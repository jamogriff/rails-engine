class ApplicationController < ActionController::API
  # modules live in models/concerns
  include Response
  include ExceptionHandler
end
