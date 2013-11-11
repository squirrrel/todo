# Be sure to restart your server when you modify this file.
require 'action_dispatch/middleware/session/dalli_store'

mem_config = YAML.load_file("#{Rails.root}/config/memcached.yml") || {}
mem_config = mem_config[Rails.env]
mem_servers = mem_config['host'].split(' ').map{|h| "#{h}:#{mem_config['port']}"}
ENV['MEMCACHE_SERVERS'] = mem_servers.join(' ')
ENV['MEMCACHE_USERNAME'] = mem_config['username']
ENV['MEMCACHE_PASSWORD'] = mem_config['password']

Rails.application.config.session_store :dalli_store, memcache_server: ENV['MEMCACHE_SERVERS'], username: ENV['MEMCACHE_USERNAME'], 
												password: ENV['MEMCACHE_PASSWORD'], namespace: 'sessions', 
												key: '_todo_session', expire_after: 30.minutes