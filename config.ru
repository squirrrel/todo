require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application

use Rack::Static,
  :urls => ["*.png", "*.jpg", "*.js", "*.css"],
  :root => "public"