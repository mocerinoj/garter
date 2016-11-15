class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  http_basic_authenticate_with name: ENV['APP_USERNAME'], password: ENV['APP_PASSWORD']
end
