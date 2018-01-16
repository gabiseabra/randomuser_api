class ApplicationController < ActionController::API
  rescue_from(ActiveRecord::RecordNotFound) { head 404 }
end
