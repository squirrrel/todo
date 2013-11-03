require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'devise'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Todo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    # config.generators do |g|
    #    g.template_engine :haml
    # end
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    #config.exceptions_app = self.routes
    config.cache_classes = true
    config.assets.enabled = true
    config.assets.version = '1.0'
    mem_config = YAML.load_file("#{Rails.root}/config/memcached.yml") || {}
    mem_config = mem_config[Rails.env]
    mem_servers = mem_config['host'].split(' ').map{|h| "#{h}:#{mem_config['port']}"}
    ENV['MEMCACHE_SERVERS'] = mem_servers.join(' ')
    
    config.cache_store = :dalli_store, ENV['MEMCACHE_SERVERS'], { namespace: 'app_cache', compress: true }
    config.active_record.observers = :cache_observer

    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    config.active_record.whitelist_attributes = false
    config.serve_static_assets = true
    config.log_level = :debug

    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.consider_all_requests_local = false
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      domain:               'example.com',
      user_name:            'nina.moskalyk@gmail.com',
      password:             'cheguevara1988',
      authentication:       'plain',
      enable_starttls_auto: true  }
  end
end
