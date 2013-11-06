# Be sure to restart your server when you modify this file.
require 'action_dispatch/middleware/session/dalli_store'

mem_config = YAML.load_file("#{Rails.root}/config/memcached.yml") || {}
mem_config = mem_config[Rails.env]
mem_servers = mem_config['host'].split(' ').map{|h| "#{h}:#{mem_config['port']}"}
ENV['MEMCACHE_SERVERS'] = mem_servers.join(' ')

Rails.application.config.session_store :dalli_store, memcache_server: ENV['MEMCACHE_SERVERS'], username: '5664af', password: '28eebde096',
													 namespace: 'sessions', key: '_todo_session', expire_after: 30.minutes