require 'spec_helper'
require './web/server.rb'
require 'rack/test'

Rspec.configure do |config|
	config.include Rack::Test::Methods
end