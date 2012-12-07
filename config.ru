require 'bundler/setup'
require 'faye'
require 'faye/redis'
require File.dirname(__FILE__) + '/app'

Faye::WebSocket.load_adapter('thin')

use Faye::RackAdapter,
        :mount   => '/faye',
        :timeout => 45,
        :engine  => {
                :type => Faye::Redis,
                :host => 'localhost',
        }

run App
