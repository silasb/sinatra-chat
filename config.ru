require 'bundler/setup'
require 'faye'
require 'faye/redis'
require File.dirname(__FILE__) + '/app'

Faye::WebSocket.load_adapter('thin')

bayeux = Faye::RackAdapter.new(
		App,
		:mount => '/faye',
        :timeout => 45,
        :engine  => {
                :type => Faye::Redis,
                :host => 'localhost',
        })

bayeux.bind(:handshake) do |client_id|
  # event listener logic
  puts client_id
end

run bayeux
