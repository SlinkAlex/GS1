# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
GS1::Application.initialize!

Rails.logger = Logger.new(STDOUT)
config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")