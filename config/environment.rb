# Load the rails application.
require File.expand_path('../application', __FILE__)

# Initialize the rails application.
Todo::Application.initialize!

Rails.logger = Logger.new("todo.log")