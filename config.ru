require 'bundler/setup'
require 'faye'
require File.dirname(__FILE__) + '/app'
Faye::WebSocket.load_adapter('thin')

use Faye::RackAdapter, :mount      => '/faye',
                       :timeout    => 45

run App
