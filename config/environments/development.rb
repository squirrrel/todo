require 'dalli'

Todo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  # Do not eager load code on boot.
  config.cache_classes = true
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local  = true
  config.action_controller.perform_caching = true
  
  mem_config = YAML.load_file("#{Rails.root}/config/memcached.yml") || {}
  mem_config = mem_config[Rails.env]
  mem_servers = mem_config['host'].split(' ').map{|h| "#{h}:#{mem_config['port']}"}
  ENV['MEMCACHE_SERVERS'] = mem_servers.join(' ')
  client = Dalli::Client.new(ENV["MEMCACHIER_SERVERS"], :value_max_bytes => 10485760)
  config.action_dispatch.rack_cache = {
    metastore: client,
    entitystore: client,
    verbose: true,
    allow_revalidate: true
  }


  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load
  # config.generators do |g|
  #   g.template_engine :haml
  # end
  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false

   config.serve_static_assets = true
   config.static_cache_control = "public, max-age=2592000"

  # # Compress JavaScripts and CSS
  config.assets.compress = true

  # # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # # Generate digests for assets URLs
  config.assets.digest = true

  # config.assets.debug = true
  config.active_record.whitelist_attributes = false
  # config.assets.precompile += ['cancelokedit.js']
  config.log_level = :debug
  config.i18n.default_locale = :en
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
end
