source 'http://rubygems.org'

ruby '2.0.0'
#ruby '1.9.3', engine: 'jruby', engine_version: '1.7.6' #uncomment once decided to use jruby_puma group 
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# group :additional do
#   gem 'protected_attributes'
#   gem 'haml'
# end
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

#this one is for heroku
gem 'rails_12factor', group: :production

group :jruby_puma do
	#gem "activerecord-jdbcmysql-adapter"
	#gem 'jdbc-mysql'
	#gem 'puma'
	#gem 'therubyrhino' #MRI therubracer analog
end

group :doc do
	# bundle exec rake doc:rails generates the API under doc/api.
	gem 'sdoc', require: false
	gem 'execjs'
end

group :mri_unicorn do
	gem 'therubyracer'
	#gem 'libv8'
	#gem 'sqlite3'
	gem 'mysql2'
	gem 'unicorn'
	gem 'unicorn-rails'
end	

group :custom do 
	gem 'sprockets-rails', :require => 'sprockets/railtie'
	gem 'actionpack-action_caching'
	gem 'protected_attributes'
	gem 'state_machine', '0.9.3'
	gem 'devise'
	gem 'dalli'
	gem 'rack-cache'
	gem 'kgio'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]