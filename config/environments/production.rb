require 'dalli'

Todo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both thread web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  mem_config = YAML.load_file("#{Rails.root}/config/memcached.yml") || {}
  mem_config = mem_config[Rails.env]
  mem_servers = mem_config['host'].split(' ').map{|h| "#{h}:#{mem_config['port']}"}
  ENV['MEMCACHE_SERVERS'] = mem_servers.join(' ')
  ENV['MEMCACHE_USERNAME'] = mem_config['username']
  ENV['MEMCACHE_PASSWORD'] = mem_config['password']

  client = Dalli::Client.new(ENV["MEMCACHE_SERVERS"], { username: ENV['MEMCACHE_USERNAME'], password: ENV['MEMCACHE_PASSWORD'], 
                                                          value_max_bytes: 15728640})
  config.action_dispatch.rack_cache = {
    metastore: client,
    entitystore: client,
    verbose: true
  }
  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=2592000"
  config.assets.enabled = true
  config.assets.version = '1.0'

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false
  #config.assets.precompile += %w(squirrel.ico ukrainian.png application.js application.css devise_wallpaper.css.sass tasks_wallpaper.css.sass)
  config.assets.precompile += %w( *.js *.css )
  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx TESTING

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( search.js )

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  #config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = false
  #config.i18n.default_locale = :en
  #config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Send deprecation notices to registered listeners.
  #config.active_support.deprecation = :log

  # Disable automatic flushing of the log to improve performance.
  config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new
end